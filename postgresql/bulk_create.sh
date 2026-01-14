for i in {1..8000}; do psql -c "create database db_${i}" postgres; done
for i in {1..8000}; do psql -c "create user u_${i}" postgres; done
for i in {1..8000}; do psql -c "alter database db_${i} owner to u_${i}" postgres; done


for i in {1..8000}
do
    for e in {1..100}
    do
        psql -c "create table tab${e}(a int primary key generated always as identity, b text, c date)" db_${i}
    done
done

