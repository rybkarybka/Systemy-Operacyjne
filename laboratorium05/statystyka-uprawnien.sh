#/bin/bash

if [[ $# != 1 ]]; then
  echo -e "Nieprawidlowa liczba argumentow\n"
  exit 1
elif [[ ! -d $1 ]]; then
  echo -e "Podany argument nie jest katalogiem\n"
  exit 1
fi

ctr=0
str=""

# niestety nie szlo w jednej linijce, bo sie echo nam psuło
# a w taki sposob jest ladnie printowane
# choc wychodzi na to samo, jakbysmy wzieli ta linijke, skopiowali i wkleili do basha
for id in `ls -la $1 | cut -d" " -f1 | uniq -c | sort -r | awk -F" " '{if ($1 > 1){print $1, $2}}'`; do
  if [[ $(( $ctr % 2 )) == 0 ]]; then
	str="$id"
	ctr=$(( $ctr + 1 ))
  else
	str="$str $id"
	echo "$str"
	ctr=$(( $ctr - 1 ))
	str=""
  fi
done
