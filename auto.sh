#!/bin/bash

i=0
while [ $i -ne 100 ]
do
  i=$(($i+1))
  echo "${i}"
  ./make_event_thumb.py -title='행운권' -t1='배민 상품권' -t2="#$i" -output="tmp/LuckyDraw#${i}.jpg"
done
