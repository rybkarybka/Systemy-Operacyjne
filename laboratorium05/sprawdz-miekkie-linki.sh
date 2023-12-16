#/bin/bash

if [[ $# != 1 ]]; then
  echo -e "Nieodpowiednia liczba argumentow, sprobuj\n./sprawdz-miekkie-linki.sh SCIEZKA"
  exit 1
elif [[ ! -d $1 ]]; then
  echo "Podany argument nie jest sciezka"
  exit 1
fi

ctr=0

# w tej tablicy beda rzeczy, które znalezliśmy juz
copy_tab=()
j=0

# skanujemy tylko pliki, ktore sa linkami
for file in `find $1 -type l`;do
  echo "------------------------------------------------"
  link=$file
  i=0
  arr=()

  # lecimy w glab linku
  while [[ `readlink $link` != "" ]];do
	arr[i]=$link
	i=$(( $i+1 ))
	link=`readlink $link`
  done

  if [[ $i > 1 ]];then
	ctr=$(( $ctr+1 ))
  fi

  echo -e "Wszystkie dowiazania z danego pliku:\n"
  for id in ${arr[@]};do
	echo $id
  done
  echo -e "\nLiczba $i\n"

done

echo "+--------------------+"
echo "+ Lacznie petli: $ctr   +"
echo "+--------------------+"
