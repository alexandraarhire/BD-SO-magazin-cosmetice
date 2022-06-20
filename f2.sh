#!/bin/bash
. f1.sh
while true
do
select option in view add  search delete update adunare out
do
case $option in
view) cat produse;;
add) add;;
search) search;;
delete) delete;;
update) update;;
adunare) adunare;;
out) exit 0;;
*) echo "Optiunea invalida";;
esac
done
done
