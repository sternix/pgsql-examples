COALESCE is a function that returns the first argument you give it that isn't NULL

COALESCE(NULL,1,2) => 1
COALESCE(NULL,NULL,NULL) => NULL
COALESCE(3,NULL,2) => 4

1) set a default value
products
name    price   discount
orange  200     NULL
apple   100     23
lemon   150     NULL

in this table, a NULL discount means there's no discount,
so we use COALESCE to set the default to 0:

SELECT name, price - COALESCE(discount, 0) as net_price FROM products

sonuç:
name    net_price
orange  200
apple   77
lemon   150

2) use data from 2 (or more) different columns

this query gets the best guess at a customer's state

SELECT customer, COALESCE(mailing_state, billing_state, ip_address_state) AS state FROM addresses

state'lerden hangisi null değilse onu kullan
eğer hepsi null ise sonuç null

-----

SELECT COALESCE(NULL, NULL, 'first non null', null, null, 'second non null');

coalesce
--------
'first non null'


SELECT COALESCE(NULL, NULL, 'HELLO WORLD');

coalesce
--------
'HELLO WORLD'


