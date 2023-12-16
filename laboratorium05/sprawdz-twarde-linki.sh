#/bin/bash

if [[ $# != 1 ]]; then
  echo -e "Nieodpowiednia liczba argumentow, sprobuj\n./sprawdz-twarde-linki.sh SCIEZKA"
  exit 1
elif [[ ! -d $1 ]]; then
  echo "Podany argument nie jest sciezka"
  exit 1
fi

# liczba dowiazan nie wliczajac tych samych dowiazan
ctr=0

# tablica z powtorkami
arr=()
i=0

for file in `find $1 -type f`;do
  # liczba linkow
  n=`stat $file | grep Links | cut -d" " -f 9`

  # sprawdzamy, czy ma jakiekolwiek linki
  if [[ $n > 1 ]]; then
	# jesli nie ma w tablicy
	if [[ ! `printf '%s\0' "${arr[@]}" | grep -F -x -z -- $file` ]]; then
	  # dodajemy do tablicy
	  j=0
	  for links in `find -links $n`;do
		j=$(( $j+1 ))
		arr[i]=$links
		i=$(( $i+1 ))
	  done
	  ctr=$(( $ctr+($j/$n)))
	fi
  fi
done

echo -e "\nLiczba roznych hardlinkow: $ctr\n"
