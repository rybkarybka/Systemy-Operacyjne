#!/bin/bash

# image magick, nalozenie w pdfie zdjecia w danym miejscu

#sprawdz czy jest wystarczajaca liczba argumentow
if [[ $# == 4 ]]; then
  fileType_v1=$(file -b $1 | cut -d' ' -f1)
  
  #sprawdz czy pierwszy plik jest pdfem
  if [[ $fileType_v1 == 'PDF' ]];then
	fileType_v2=$(file -b $2 | cut -d' ' -f1)
	
	#sprawdz czy drugi plik jest png
	if [[ $fileType_v2 == 'PNG' ]];then
	 
	  #sprawdz czy x i y sa ok
	  if (( $3 >= 0 && $4 >= 0 ));then
		#magiczna komenda, ktora robi robote
		magick composite -geometry $3x$4 $2 $1 done.pdf
	  else
		echo "$3 lub $4 sa mniejsze od 0"
	  fi
	else
	  echo "$2 nie jest plikiem PNG"
	fi
  else
	echo "$1 nie jest plikiem PDF"
  fi
else
  echo "Za malo argumentow"
fi
