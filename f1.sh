#!/bin/bash
function add () {
while true
do
read -p "Cantitatea produsului:" cantitate
read -p "Numele produsului:" produs
if [[ $produs =~ ^[a-zA-Z" "]+$ ]];then
echo "Produsul contine litere"
else
echo "Numele produsului nu a fost introdus corect,datele introduse nu sunt valide"
fi
read -p "Pretul produsului:" pret
if  [[ $pret =~ ^[0-9]+$ ]];then
echo "Pretul contine numere"
else
echo "Pretul nu a fost introdus corect,datele introduse nu sunt valide"
fi
read -p "Categoria produsului:" categorie
read -p "Codul produsului:" cod
if [ ${#cod} -eq 4 ];then
echo "Codul este bun"
else
echo "Codul nu contine 4 cifre,datele introduse nu sunt valide"
fi
read -p "Termenul de expirare al produsului:" expirare
echo $cantitate $produs $pret $categorie $cod $expirare
read -p "Datele introduse sunt valide?(D/N)" raspuns
case $raspuns in
[Dd]) echo $cantitate $produs $pret $categorie $cod $expirare >> produse
echo "Continuati? (D/N)"; read raspuns
if [ $raspuns = "D" -o $raspuns = "d" ]
then continue
else return
fi
;;
[Nn]) echo "Incercati din nou?(D/N)"; read raspuns
case $raspuns in
[Dd]) continue;;
[Nn]) return;;
*) echo "Optiune invalida.";;
esac;;
esac
done
}
function delete () {
echo "Dati codul produsului pe care vreti sa-l stergeti"; read cod
if [ $cod = "" ]
then continue
fi
sed -e /"$cod"/d produse > produse.nou
mv produse.nou produse
}
function search () {
echo "Dati numele produsului pe care vreti sa-l cautati"; read produs
grep -i $produs produse > /dev/null
if test $? -eq 0
then grep -i $produs produse
else
echo "Nu exista produse inregistrate cu acest nume"
fi
}
function update () {
echo "Numele produsului ce trebuie cautat:"; read produs
echo "Pretul vechi al produsului:"; read pret1;
echo "Noul pret al produsului:"; read pret2;
sed -e s/"$pret1"/"$pret2"/ produse > produse.nou
if [ $? -eq 0 ]
then
mv produse.nou produse
else
echo "Eroare!"
fi
}
function adunare () {
awk 'BEGIN{sum=0} {sum=sum+$1} END {print sum}' produse
}
