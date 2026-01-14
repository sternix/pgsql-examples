CREATE MATERIALIZED VIEW mat_view AS
           SELECT   grp, avg(data), count(*)
           FROM     t_demo
           GROUP BY 1;

ALTER MATERIALIZED VIEW mat_view
     RENAME COLUMN avg TO average;

CREATE INDEX idx_average ON mat_view (average);

REFRESH MATERIALIZED VIEW mat_view;

kısaca materialized view'ler cache gibi
istediğimiz zaman cache'i refresh edip yenileyebiliyoruz

refresh yaptığımızda refresh bitene kadar kimse view'e erişemiyor.

By default, a materialized view is created in a way that it contains the result. However, if the object is created using the NO DATA option, it is empty. Only the definition is created.