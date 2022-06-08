# /usr/bin/bash 
szdq=/home/pjiao/git/szdq/install/bin/sz
sz3=/home/pjiao/git/SZ3/install/bin/sz3
file=$1
file=/lcrc/project/ECP-EZ/jp/aramco/aramco-snapshot-1199.f32
filename=$(basename $file)
dim=$2
dim='3 235 449 449'
size=47376235
eb1=$(python3 rel2abs.py $file  $3)
eb2=$(python3 rel2abs.py $file  $4)
eb3=$(python3 rel2abs.py $file  $5)
echo "filename = $filename " >> $filename.log
echo "eb1 = $eb1" >> $filename.log
echo "eb2 = $eb2" >> $filename.log
$sz3 -f -i $file -o $filename.sz3.out -$dim -M ABS $eb1 -a >> $filename.log 
python3 error.py $file $filename.sz3.out $filename.sz3.error

## Using dq on error 
cp $filename.sz3.error error.dat
for eb in $eb2 $eb3
do
	echo "$szdq -z -f -c sz.config -i error.dat -o error.dat.sz -1 $size -M ABS -A $eb -a >> $filename.log"
	$szdq -z -f -c sz.config -i error.dat -s error.dat.sz -1 $size -M ABS -A $eb  >> $filename.log
	$szdq -x -f -s error.dat.sz -i error.dat -1 $size -a >> $filename.log
	python3 error.py error.dat error.dat.sz.out error.dat
done

## using sz3 on error 
cp $filename.sz3.error error.dat
for eb in $eb2 $eb3
do
	$sz3 -f -i error.dat -o error.dat.sz3.out -$dim  -M ABS $eb -a >> $filename.log 
	python3 error.py error.dat error.dat.sz3.out error.dat
done

## Using sz3 on data 
for eb in $eb2 $eb3
do       
	$sz3 -f -i $file -o $filename.sz3.out -$dim -M ABS $eb -a >> $filename.log
done



## eb2 on error

#szdq -z  -f -c sz.config -i $filename.sz3.error -1 $size -M ABS -A $eb2  >> $filename.log 

#szdq -x  -f  -i $filename.sz3.error  -s $filename.sz3.error.sz -1 $size -a >> $filename.log 

#sz3 -f -i $filename.sz3.error  -o $filename.sz3.error.out -$dim -M ABS $eb2 -a >> $filename.log


#sz3 -f -i $file -o $filename.out -$dim -M ABS $eb2 -a >> $filename.log

# eb3 on error 

#./error $dim $file$filename.out $filename.error

rm *.dat  *.out *.sz *.error 



