i=0 
o=$1
old=1
for l in `cat cuts.txt`
do 
new=$(($l+o))
echo $i $old-$(($new-1))
pdftk main.pdf cat $old-$(($new-1)) output $i.pdf 
old=$new
i=$(($i+1))
done
