-- tekrarlayan indeksler

SELECT
    indrelid::regclass as TableName
    , array_agg(indexrelid::regclass) as Indexes
FROM pg_index
GROUP BY indrelid, indkey
HAVING COUNT(*) > 1;