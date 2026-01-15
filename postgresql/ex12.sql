-- https://twitter.com/ryanbooz/status/1469381800552288259/photo/1

SELECT ts,country,product, quantity, price
    LAST_VALUE(price) OVER w AS last_price_at_least_five_minutes_ago
FROM purchase
WINDOW w AS (PARTITION BY product ORDER BY ts RANGE
    BETWEEN UNBOUNDED PRECEDING AND '5 minutes'::INTERVAL PRECEDING)
ORDER BY ts;