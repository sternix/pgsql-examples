CASE
    WHEN <condition> THEN <result>
    WHEN <other-condition> THEN <result>
    ELSE <result>
END

SELECT
    first_name,
    age,
    CASE
        WHEN age < 13 THEN 'child'
        WHEN age < 20 THEN 'teenager'
        ELSE 'adult'
    END AS age_range
FROM people