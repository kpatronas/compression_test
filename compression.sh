#!/bin/bash

echo "Testing the gzip tool"
os=`ls -l enwik8 | tr -s " " | cut -d " " -f5`
echo "compression_level time compression_max_mem compressed_size original_size compression_ratio decompression_time decompression_max_mem"
for i in $(seq 1 9);
do
  tsm=`/usr/bin/time -f "%E %M" gzip -$i -c ./enwik8 > enwik8.gz 2> ts.txt && cat ts.txt`
  ts=`echo $tsm | cut -d " " -f1`
  cm=`echo $tsm | cut -d " " -f2`
  cs=`ls -l enwik8.gz  | tr -s " " | cut -d " " -f5`
  rt=`echo $os $cs | awk '{print ($1-$2)/$1*100}'`
  rm -rf ./enwik8
  dtm=`/usr/bin/time -f "%E %M" gzip -d ./enwik8.gz 2> ts.txt && cat ts.txt`
  dt=`echo $dtm | cut -d " " -f1`
  dm=`echo $dtm | cut -d " " -f2`
  echo "$i $ts $cm $cs $os $rt $dt $dm"
done
echo ""

echo "Testing the bzip tool"
echo "compression_level time compression_max_mem compressed_size original_size compression_ratio decompression_time decompression_max_mem"
for i in $(seq 1 9);
do
  tsm=`/usr/bin/time -f "%E %M" bzip2 -$i ./enwik8 2> ts.txt && cat ts.txt`
  ts=`echo $tsm | cut -d " " -f1`
  cm=`echo $tsm | cut -d " " -f2`
  cs=`ls -l enwik8.bz2  | tr -s " " | cut -d " " -f5`
  rt=`echo $os $cs | awk '{print ($1-$2)/$1*100}'`
  dtm=`/usr/bin/time -f "%E %M" bzip2 -d ./enwik8.bz2 2> ts.txt && cat ts.txt`
  dt=`echo $dtm | cut -d " " -f1`
  dm=`echo $dtm | cut -d " " -f2`
  echo "$i $ts $cm $cs $os $rt $dt $dm"
done
echo ""

echo "Testing the xz tool"
echo "compression_level time compression_max_mem compressed_size original_size compression_ratio decompression_time decompression_max_mem"
for i in $(seq 1 9);
do
  tsm=`/usr/bin/time -f "%E %M" xz -$i ./enwik8 2> ts.txt && cat ts.txt`
  ts=`echo $tsm | cut -d " " -f1`
  cm=`echo $tsm | cut -d " " -f2`
  cs=`ls -l enwik8.xz  | tr -s " " | cut -d " " -f5`
  rt=`echo $os $cs | awk '{print ($1-$2)/$1*100}'`
  dtm=`/usr/bin/time -f "%E %M" xz -d ./enwik8.xz 2> ts.txt && cat ts.txt`
  dt=`echo $dtm | cut -d " " -f1`
  dm=`echo $dtm | cut -d " " -f2`
  echo "$i $ts $cm $cs $os $rt $dt $dm"
done
