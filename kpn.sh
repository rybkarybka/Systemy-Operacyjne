#!/bin/bash

echo "Witaj w grze Kamień-Papier-Nożyce!"

options=("k" "p" "n")

# Funkcja do generowania losowego ruchu komputera
function computer_move {
    echo ${options[$((RANDOM % 3))]}
}

# Funkcja do sprawdzenia wyniku gry
function check_result {
    user_choice=$1
    computer_choice=$2

    if [ "$user_choice" == "$computer_choice" ]; then
        echo "Remis!"
    elif [ "$user_choice" == "k" -a "$computer_choice" == "n" ] || [ "$user_choice" == "p" -a "$computer_choice" == "k" ] || [ "$user_choice" == "n" -a "$computer_choice" == "p" ]; then
        echo "Gratulacje, wygrałeś!"
    else
        echo "Niestety, przegrałeś."
    fi
}

# Wybór użytkownika
select option in "${options[@]}"; do
    case $option in
        "k"|"p"|"n")
            user_choice=$option
            computer_choice=$(computer_move)
            
            echo "Twój wybór: $user_choice"
            echo "Komputer wybrał: $computer_choice"

            check_result $user_choice $computer_choice
            break
            ;;
        *)
            echo "Nieprawidłowy wybór. Wybierz k, p lub n."
            ;;
    esac
done





#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Podaj dwie liczby jako argumenty podczas uruchamiania skryptu."
  exit 1
fi

wynik=$(($1 * $2))

echo "Wynik mnożenia: $wynik"