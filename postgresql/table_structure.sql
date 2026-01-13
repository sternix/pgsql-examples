select
   ordinal_position as "Pos",
   column_name as "Col",
   data_type as "Type",
   coalesce(character_maximum_length, numeric_precision_radix , datetime_precision) as "Prec",
   is_nullable as "Nullable",
   column_default as "Default",
   udt_name as "Built-In"
from information_schema.columns where table_name = 'tbltest'
order by ordinal_position;