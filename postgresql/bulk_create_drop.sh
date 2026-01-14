# create

#!/bin/bash
NUMOFDBS=100
for i in `seq ${NUMOFDBS}`; do
    psql -q -c "create user u${i} UNENCRYPTED password 'u${i}' NOCREATEDB NOCREATEROLE NOCREATEUSER" postgres
    createdb -O u${i} db${i}
done


# drop 

#!/bin/bash
NUMOFDBS=100
for i in `seq ${NUMOFDBS}`; do
    dropdb db${i}
    dropuser u${i}
done