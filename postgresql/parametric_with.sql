with attendance (class, section, name) as(values
    (1, 1, 'Amy'),
    (1, 1, 'Bill'),
    (1, 2, 'Charlie'),
    (1, 2, 'Dan'),
    (2, 1, 'Emily'),
    (2, 1, 'Fred'),
    (2, 2, 'George')
)
select *
from attendance
where (class, section) = any(array[(1,1),(2,2)]);