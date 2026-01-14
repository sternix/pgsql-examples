CREATE TABLE mytable (data JSONB NOT NULL);
CREATE INDEX mytable_idx ON mytable USING gin (data jsonb_path_ops);
INSERT INTO mytable VALUES($$
{
    "name": "Alice",
    "emails": [
        "alice1@test.com",
        "alice2@test.com"
    ],
    "events": [
        {
            "type": "birthday",
            "date": "1970-01-01"
        },
        {
            "type": "anniversary",
            "date": "2001-05-05"
        }
    ],
    "locations": {
        "home": {
            "city": "London",
            "country": "United Kingdom"
        },
        "work": {
            "city": "Edinburgh",
            "country": "United Kingdom"
        }
    }
}
$$);


SELECT data->>'name' FROM mytable WHERE data @> '{"name":"Alice"}';

Query for a simple item in an array:

SELECT data->>'name' FROM mytable WHERE data @> '{"emails":["alice1@test.com"]}';

Query for an object in an array:

SELECT data->>'name' FROM mytable WHERE data @> '{"events":[{"type":"anniversary"}]}';

Query for a nested object:

SELECT data->>'name' FROM mytable WHERE data @> '{"locations":{"home":{"city":"

SELECT data FROM mytable WHERE data @> '{"name":"Alice"}';
SELECT data FROM mytable WHERE data->'name' = '"Alice"';
SELECT data FROM mytable WHERE data->>'name' = 'Alice';

SELECT data->'locations'->'work' FROM mytable WHERE data @> '{"name":"Alice"}';
SELECT data->'locations'->'work'->>'city' FROM mytable WHERE data @> '{"name":"Alice"}';