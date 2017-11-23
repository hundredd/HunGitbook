#! /bin/bash
pth="./"
for file in `ls $pth|grep '@2x*'`
#for file in `find $pth -name '@2x*'`
do
    # if [["$file" == *"@2x"* ]]
    # if [["$file" == *"@2x"* ]]
    if true
     then
        echo "\n原来的字符串===> $file"
        tmpName=`echo $file|sed 's/@2x//'`
        echo "\n改变后的文件名"
        echo "${tmpName}"
        mv "$pth$file" "$pth${tmpName}"
     else
        echo "不操作$file"
    fi
done
