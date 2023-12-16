# Komendy z Laboratorium 05
## Żeby nie wrzucać potężnych plików na GH, to dam instrukcje jak to zrobić

### Zadanie 0

1. Utworzenie pustego pliku o rozmiarze 100MB
	`dd if=/dev/zero of=empty_file bs=1M count=100`

2. Utworzenie pliku wypełnionego losowymi danymi
	`dd if=/dev/urandom of=random_file bs=1M count=100`

3. Utworzenie pliku z powielonymi danymi losowymi
	`dd if=/dev/urandom of=duplicated_file bs=1M count=10`
	`touch this_file`
	`cat duplicated_file >> this_file` -> powtarzamy 10 razy

### Zadanie 1.1

- Pliki można spakować np w taki sposób: `gzip -k FILE`.
- Następnie, by sprawdzić jak mocno zostały skompresowane, można użyć komendy `du ARCHIWUM`

### Zadanie 1.2

- Dowiązanie miękkie: `ln -s FILE NAME`
- Dowiązanie twarde: `ln FILE NAME`
- Sprawdzanie pamięci: `du NAME`
- Za pomocą komendy `stat NAME` mamy podane więcej szczegółów

### Zadanie 1.3

- Zakładanie systemu plików ext4: `mkfs.ext4 FILE`
- Za pomocą `dumpe2fs FILE` można odczytać UUID tego pliku
- By móc montować to bez roota, trzeba edytować plik `/etc/fstab`, przykład: `sudo vim /etc/fstab`
- Dodajemy linijkę: `UUID=uuid /sciezka/kaj/montujemy ext4 rw,user,noauto`
- Jak o niczym nie zapomniałem to powinno to zadziałać, trzeba jeszcze wykonać polecenie: `mount FILE` i chyba wszystko zadziała

### Zadanie 1.5 

Wsadzę tutaj też zdjęcie z wykresu, ale mordki nie musicie 1:1 kopiować

### Zadanie 1.6

Żeby nie wyskakiwały ostrzeżenia, to polecam uruchomić w taki sposób:
`./sprawdz-twarde-linki.sh SCIEZKA 2>/dev/null`