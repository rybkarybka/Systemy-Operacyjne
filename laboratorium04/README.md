## Komenda do odczytywania RSS z pliku (zadanie 1)

Jak jest to jako bash to kompletnie inne wyniki wychodza, nie wiem czemu

```bash
cat /proc/`pidof stackheap`/smaps | grep Rss | awk -F" " '{print $2}' | sum | awk -F" " {print $1}
```

## Jak ustawić limit dla np. VMEM?

Jeśli chcemy utawić limit możliwej do pozyskania wirtualnej pamięci dla procesu należy wpisać:

```bash
ulimit -v x
```

Gdzie x to jest w kB. Przykład:

```bash
[linas@fedora laboratorium04]$ ulimit
unlimited
[linas@fedora laboratorium04]$ ulimit -v 1000000
[linas@fedora laboratorium04]$ ./incmemusage 
Before allocating array

After allocating array

Segmentation fault (core dumped)
[linas@fedora laboratorium04]$
```
