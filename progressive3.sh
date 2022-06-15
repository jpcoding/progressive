# !/usr/bin/bash 
file=$1
filename=$(basename $file)
dim=$2
dims=$3
eb1=$(python3 rel2abs.py $file $4)
eb2=$(python3 rel2abs.py $file $5)
eb3=$(python3 rel2abs.py $file $6)

echo "$filename" >> $filename.log 
echo "eb1 = $eb1 "  >> $filename.log 
echo "eb2 = $eb2 "  >> $filename.log 
echo "eb3 = $eb3 "  >> $filename.log 


## compressors 
sz3=/home/jp/git/SZ3/install/bin/sz
dq=/home/jp/git/sz2-dq/example/sz

## SZ on data three times 
echo "SZ3 on $filename" >> $filename.log 
$sz3 -f -i $file -o $filename.sz3.out -$dim $dims  -M ABS $eb1 -a >> $filename.log
$sz3 -f -i $file -o $filename.sz3.out -$dim $dims  -M ABS $eb2 -a >> $filename.log
$sz3 -f -i $file -o $filename.sz3.out -$dim $dims  -M ABS $eb3 -a >> $filename.log

## SZ3 sz3_e sz3_e 
echo "SZ3 sz3_e sz3_e on $filename" >> $filename.log
$sz3 -f -i $file -o $filename.sz3.out -$dim $dims  -M ABS $eb1 -a >> $filename.log
python3 error.py $file $filename.sz3.out $filename.sz3.out.error1
$sz3 -f -i $filename.sz3.out.error1 -o $filename.sz3.out.error1.out -$dim $dims  -M ABS $eb2 -a  >> $filename.log
python3 error.py  $filename.sz3.out.error1 $filename.sz3.out.error1.out  $filename.sz3.out.error2
$sz3 -f -i $filename.sz3.out.error2 -o $filename.sz3.out.error2.out -$dim $dims  -M ABS $eb3 -a  >> $filename.log
python3 verify.py $file $filename.sz3.out $filename.sz3.out.error1.out $filename.sz3.out.error2.out >> $filename.log



## sz3 sz3_e dq 

echo "SZ3 sz3_e sz3_e on $filename" >> $filename.log
$sz3 -f -i $file -o $filename.sz3.out -$dim $dims  -M ABS $eb1 -a >> $filename.log
python3 error.py $file $filename.sz3.out $filename.sz3.out.error1
$sz3 -f -i $filename.sz3.out.error1 -o $filename.sz3.out.error1.out -$dim $dims  -M ABS $eb2  >> $filename.log

python3 error.py  $filename.sz3.out.error1  $filename.sz3.out.error1.out  $filename.sz3.out.error2 

size=134217728
$dq -z -f -c sz.config -i $filename.sz3.out.error2 -s $filename.sz3.out.error2.sz -1 $size -M ABS -A $eb3 >> $filename.log 
$dq -x -f -s $filename.sz3.out.error2.sz -i $filename.sz3.out.error2  -1 $size -a >> $filename.log

python3 verify.py $file $filename.sz3.out $filename.sz3.out.error1.out $filename.sz3.out.error2.sz.out >> $filename.log

rm *.out *.sz *.errro *.error1 *.error2 *.dat 