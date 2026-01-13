DROP table orders cascade;
DROP table inventory cascade;
DROP table catalog cascade;
CREATE TABLE catalog (
        item_name       text PRIMARY KEY,
        item_description        text
);

CREATE TABLE inventory (
        item_name       text references catalog (item_name),
        in_stock        integer,
        price   numeric,
        st      timestamp default current_timestamp,
        et      timestamp,
        UNIQUE (item_name, st, et)
);
CREATE UNIQUE INDEX inventory_ridx ON inventory (item_name) WHERE et IS NULL;

CREATE VIEW current_inventory AS
   SELECT item_name, in_stock, price FROM inventory
   WHERE et IS NULL;

CREATE OR REPLACE FUNCTION inventory_at_time(timestamp with time zone)
RETURNS SETOF current_inventory AS
$$
   SELECT item_name, in_stock, price from inventory
      WHERE (SELECT CASE WHEN et IS NULL
            THEN (st <= $1)
            ELSE (st <= $1 AND et > $1)
            END) ;
$$ LANGUAGE 'sql';

CREATE RULE inv_del AS ON DELETE TO inventory
   DO INSTEAD
        UPDATE inventory SET et=current_timestamp
   WHERE item_name = OLD.item_name AND et IS NULL;

CREATE OR REPLACE FUNCTION upd_inventory()
RETURNS TRIGGER AS
$$
        BEGIN
        -- RAISE NOTICE 'UPD_INV TRIGGER';
           IF OLD.et IS NOT NULL THEN -- NEW.et can be non-null
              RETURN NULL; -- return quietly to avoid notice on update et
           END IF;
           IF NEW.et IS NULL THEN
              INSERT INTO inventory VALUES
                                (OLD.item_name, OLD.in_stock, OLD.price, OLD.st, current_timestamp);
              NEW.st = current_timestamp;
           END IF;
           RETURN NEW;
        END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER upd_inventory BEFORE UPDATE ON inventory
FOR EACH ROW EXECUTE PROCEDURE upd_inventory();

CREATE TABLE orders (
        order_id        SERIAL,
        order_date      date default current_date,
        vendor  text,
        item_name       text    references catalog (item_name),
        amount  integer,
        st      timestamp  default current_timestamp,
        et      timestamp,
        UNIQUE (order_id, st, et)
);
CREATE UNIQUE INDEX orders_ridx ON orders (order_id) WHERE et IS NULL;

CREATE VIEW current_orders AS
   SELECT order_id, order_date, vendor, amount, item_name
   FROM orders
   WHERE et IS NULL;

CREATE OR REPLACE FUNCTION orders_at_time(timestamp without time zone)
RETURNS SETOF current_orders AS
$$
   SELECT order_id, order_date, vendor, amount, item_name
   FROM orders
   WHERE (SELECT CASE WHEN et IS NULL
         THEN (st <= $1)
         ELSE (st <= $1 AND et > $1)
         END) ;
$$
LANGUAGE SQL;

CREATE RULE ord_del AS ON DELETE TO orders
   DO INSTEAD
   UPDATE orders set et=current_timestamp
   WHERE order_id = OLD.order_id AND et IS NULL;

CREATE OR REPLACE FUNCTION upd_orders()
RETURNS TRIGGER AS
$$
   BEGIN
        -- RAISE NOTICE 'UPD_ORDERS TRIGGER';
      IF OLD.et IS NOT NULL THEN -- NEW.et can be non-null
              RETURN NULL; -- return quietly to avoid notice on update et
      END IF;
      IF NEW.et IS NULL THEN
                -- RAISE NOTICE 'UPD_ORDERS INSERT OLD CASE';
         INSERT INTO orders VALUES
            (OLD.order_id, OLD.order_date, OLD.vendor,
                                 OLD.item_name, OLD.amount, OLD.st, current_timestamp);
         NEW.st = current_timestamp;
      END IF;
        -- RAISE NOTICE 'UPD_ORDERS DEL CASE';
        -- RAISE NOTICE 'NEW: order %  item % st % et % ', NEW.order_id, NEW.item_name, NEW.st, NEW.et;
      RETURN NEW;
   END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER upd_orders BEFORE UPDATE ON orders
FOR EACH ROW EXECUTE PROCEDURE upd_orders();

CREATE OR REPLACE FUNCTION receive_order(r_order_id integer)
RETURNS integer AS
$$
DECLARE
rowcount integer;
orec RECORD;
BEGIN
        -- preselect valid order record or raise error
        SELECT into orec order_id, item_name, amount from current_orders o
        WHERE o.order_id = r_order_id;
        IF NOT FOUND THEN
                RAISE EXCEPTION 'Cannot Receive Order % -- has order already been received?',
                                                 r_order_id;
        END IF;
-- insert or update inventory record
   LOOP
      UPDATE inventory SET in_stock = in_stock + orec.amount
      WHERE inventory.item_name = orec.item_name;
      IF FOUND THEN
        DELETE FROM orders WHERE order_id = r_order_id;
         RETURN r_order_id;
      ELSE
         BEGIN
            INSERT INTO inventory VALUES
                (orec.item_name, orec.amount, NULL);
         EXCEPTION WHEN unique_violation THEN
            -- do nothing: loop around
         END;
      END IF;
   END LOOP;
   RETURN -1;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION sale(sale_item_name text, sale_amount integer)
RETURNS void AS
$$
update inventory set in_stock = in_stock - $2
where item_name = $1;
$$ LANGUAGE SQL;

-- initialize catalog
insert into catalog values ('widgets');
insert into catalog values ('thingies');
insert into catalog values ('whatchamacallits');
insert into catalog values ('thatstuff');
insert into catalog values ('thisstuff');

-- initialize inventory (optional)
insert into inventory values ('widgets', 30);
insert into inventory values ('thingies', 25);
insert into inventory values ('whatchamacallits', 50);
insert into inventory values ('thatstuff', 40);
insert into inventory values ('thisstuff', 60);

-- on create order(vendor, item_name, amount):
insert into orders values (default, default, 'WidgetsRUS', 'widgets', 100);
insert into orders values (default, default, 'Things4all', 'thingies', 200);
insert into orders values (default, default, 'WhatsGalore', 'whatchamacallits', 25);
insert into orders values (default, default, 'StuffInc', 'thatstuff', 50);
insert into orders values (default, default, 'StuffInc', 'thisstuff', 75);

-- See
select * from catalog;
select * from inventory;
select * from orders;

-- Correct order
update orders set amount = amount + 20 where order_id = 3;
select * from current_orders;
select order_id, item_name, amount, st, et from orders where order_id=3;

-- Cancel an order
delete from orders where order_id = 3;
select * from current_orders;
select * from orders;
-- Cannot update a cancelled order
update orders set amount = amount + 10 where order_id = 3;

-- Receive an order
select * from current_orders where order_id = 1;
select * from current_inventory where item_name = 'widgets';
select receive_order(1);
select * from current_orders;
select * from orders;
select * from current_inventory;
select * from inventory;

-- Sale of an item
update inventory set in_stock = in_stock - 11 where item_name = 'thisstuff';
select sale('thisstuff', 11);
select * from current_inventory;
select * from inventory;
select sale ('thingies',5);
-- At Time Selections
select * from inventory_at_time ( '2006-04-26 21:04:43.389516' );
select * from orders_at_time ( '2006-07-26 21:04:43.389516' );

-- Joining tables on the same time:
select i.item_name, i.in_stock, sum(o.amount) as on_order, 'xxx' as time
from inventory_at_time('xxx') i
left outer join orders_at_time('xxx') o
   on (i.item_name = o.item_name)
group by item_name, i.in_stock, time
order by i.item_name;

