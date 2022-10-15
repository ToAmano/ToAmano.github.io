#!/opt/homebrew/bin/bash

0;95;0c


# [ut61-1]: solutions/todai/todai-zenki/1961/61-1/ut-61-1.pdf
# for i in {61..99}
for i in {00..14}
do
    for j in {1..6}
    do
	echo ${i}
	echo [ut${i}-${j}]: solutions/todai/todai-zenki/20${i}/${i}-${j}/ut-${i}-${j}.pdf >> entex_top.md 
    done
done

	
