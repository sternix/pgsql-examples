-- Prepared Statements

PREPARE preparedInsert (int, varchar) AS
INSERT INTO tableName (intColumn, charColumn) VALUES ($1, $2);

EXECUTE preparedInsert (1,'a');
EXECUTE preparedInsert (2,'b');

DEALLOCATE preparedInsert;