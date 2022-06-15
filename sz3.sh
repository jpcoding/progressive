# /usr/bin/bash 

file=$1
file='/home/jp/data/NYX/velocity_x.dat'
dims=$2
eb1=$3
eb2=$4
filename=$(basename $file)
echo "filename = $filename" >> $filename.sz3log
echo "eb1 = $eb1" >> $filename.sz3log
echo "eb2 = $eb2" >> $filename.sz3log
sz3 -f -i $file -o $filename.out -$dims -M REL $eb1 -a >> $filename.sz3log
echo "sz3 -f -i $file -o $filename.out -$dims -M REL $eb1 -a >> $filename.sz3log"
sz3 -f -i $file -o $filename.out -$dims -M REL $eb2 -a >> $filename.sz3log
rm *out
