#!/bin/bash

rm -f a.*;
rm -f b.*;
rm -f c.*;
echo "Taille du disque: " >> a.info;
df -h | grep sda[0-9] >> a.info 2>> a.error;
cat /proc/meminfo | grep MemTotal >> a.info 2>> a.error;
cat /proc/cpuinfo | grep -m 1 "cpu cores"  >> a.info 2>> a.error;
echo "Détails du GPU: " >> a.info;
lspci -v -s 01:00.0 >> a.info 2>> a.error;

echo -n "Taille du répertoire courant: " >> b.info;
du -hs >> b.info 2>> b.error;
echo -n "Taille des fils du répertoire courant: " >> b.info;
du -h --max-depth=1 >> b.info 2>> b.error;
echo -n "Quota utilisé: " >> b.info;
quota | tail -1 | awk '{print $1}' >> b.info 2>> b.error;
echo -n "Nombre de fichiers dans la session: " >> b.info;
find . -type f | wc -l >> b.info 2>> b.error;

echo "Les 10 processus utilisant le plus de mémoire: " >> c.info;
top -o %MEM -o %CPU -b -n 1 | head -n 17 >> c.info 2>> c.error;



