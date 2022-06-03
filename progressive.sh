# /usr/bin/bash 

file=$1
file=/home/jp/data/NYX/velocity_x.dat 
filename=$(basename $file)
dim=$2
dim='3 512 512 512' 
eb1=$(python3 rel2abs.py $file  $3)
eb2=$(python3 rel2abs.py $file  $4)
echo "filename = $filename " >> $filename.log
echo "eb1 = $eb1" >> $filename.log
echo "eb2 = $eb2" >> $filename.log
sz3 -f -i $file -o $filename.sz3.out -$dim -M ABS $eb1 -a >> $filename.log 
./error $dim $file $filename.sz3.out $filename.sz3.error

sz-dq -z  -f -c sz.config -i $filename.sz3.error -1 134217728 -M ABS -A $eb2  >> $filename.log 

sz-dq -x  -f  -i $filename.sz3.error  -s $filename.sz3.error.sz -1 134217728 -a >> $filename.log 

sz3 -f -i $filename.sz3.error  -o $filename.sz3.error.out -$dim -M ABS $eb2 -a >> $filename.log


sz3 -f -i $file -o $filename.out -$dim -M ABS $eb2 -a >> $filename.log

rm *.dat  *.out *.sz *.error 



