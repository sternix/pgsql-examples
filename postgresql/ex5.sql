CREATE TABLE items
(
        item_id  SERIAL PRIMARY KEY,
        item_name TEXT
);

CREATE TABLE topics
(
        topic_id SERIAL PRIMARY KEY,
        topic_name  TEXT,
        parent_id   INTEGER REFERENCES topics (topic_id)
);

CREATE TABLE item_topics
(
        item_id  INTEGER,
        topic_id INTEGER,
        FOREIGN KEY (item_id) REFERENCES items (item_id) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (topic_id) REFERENCES topics (topic_id) ON UPDATE CASCADE,
        PRIMARY KEY (item_id, topic_id)
);

INSERT INTO topics VALUES (default, 'History', NULL );

INSERT INTO items VALUES (default, 'Studying History' );

INSERT INTO item_topics VALUES
(
        (SELECT item_id FROM items WHERE item_name = 'Studying History'),
        (SELECT topic_id FROM topics WHERE topic_name='History' )
);

CREATE VIEW it AS
   SELECT i.item_id, i.item_name, it.topic_id, t.parent_id, t.topic_name
   FROM item_topics it JOIN items i USING (item_id)
      JOIN topics t USING (topic_id);

SELECT item_name, topic_name FROM it;


CREATE OR REPLACE function del_topic() RETURNS TRIGGER AS $$
DECLARE
        r_rec RECORD;
BEGIN
        FOR r_rec IN SELECT item_id, topic_id  FROM item_topics  WHERE topic_id = OLD.topic_id
        LOOP
                IF OLD.parent_id IS NULL THEN
                        RAISE EXCEPTION 'Cannot delete topic % until its records are reassigned.',
                        OLD.topic_name;
                ELSE
                        UPDATE item_topics SET topic_id = OLD.parent_id WHERE rec_id = r_id AND topic_id =  t_id;
                END IF;
        END LOOP;

      UPDATE topics SET parent_id=OLD.parent_id WHERE parent_id = OLD.topic_id;
      RETURN OLD;
   END;
$$ language 'plpgsql';

CREATE TRIGGER del_topic BEFORE DELETE ON topics FOR EACH ROW EXECUTE PROCEDURE del_topic();

CREATE OR REPLACE FUNCTION get_topic_path( integer ) RETURNS TEXT AS $$
DECLARE
        path  text;
        topic RECORD;
BEGIN
        SELECT INTO topic topic_name, parent_id FROM topics WHERE topic_id = $1;
        path := topic.topic_name;
        IF topic.parent_id IS NOT NULL
        THEN
                path := (SELECT get_topic_path(topic.parent_id)) || ', ' || path;
        END IF;
        RETURN path;
END;
$$ LANGUAGE 'plpgsql';

select topic_name, get_topic_path( topic_id ) from topics;
select item_name, get_topic_path(topic_id) from it;


CREATE TYPE topic_node AS (tn_id integer, tn_parent integer);

CREATE or REPLACE FUNCTION get_topic_node( integer ) RETURNS SETOF topic_node AS $$
DECLARE
        t_parent INTEGER;
        t topic_node;
        t2 topic_node;
BEGIN
        FOR t IN SELECT topic_id, parent_id FROM topics WHERE topic_id = $1
        LOOP
                IF t.tn_parent IS NOT NULL
                THEN
                        FOR t2 IN SELECT * FROM get_topic_node(t.tn_parent)
                        LOOP
                                RETURN NEXT t2;
                        END LOOP;
                END IF;
                RETURN NEXT t;
        END LOOP;
        RETURN;
END;
$$ language 'plpgsql';

CREATE TYPE item_path AS (item_id integer, topic_id integer);

CREATE OR REPLACE FUNCTION item_path () RETURNS SETOF item_path AS $$
DECLARE
        it item_path;
        i record;
        tn topic_node;
BEGIN
        FOR i IN select item_id, topic_id from item_topics
        LOOP
                it.item_id = i.item_id;
                FOR tn IN SELECT  * from get_topic_node ( i.topic_id )
                LOOP
                        it.topic_id = tn.tn_id;
                        RETURN NEXT it;
                END LOOP;
        END LOOP;
        RETURN;
END;
$$ language 'plpgsql';

SELECT it.item_id, i.item_name, it.topic_id, t.topic_name
FROM items i, topics t, item_path() it
WHERE it.item_id = i.item_id AND it.topic_id = t.topic_id;