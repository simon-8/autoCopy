#!/bin/bash
# author Liu
######## Custom Function ########
EchoThenExit()
{
	echo $1
	exit 0;
}
######## Custom Function ########
echo `clear`
echo "#########################################"
echo `date`
echo "Welcome, ${USER}!  "
echo "###############成功文件##################"
folder=$1
target=$2
# 源文件夹
if [ -z "$folder" ]
	then
	EchoThenExit "Please Input Source Folder!"
fi

if [ ! -d "$folder" ]
	then
	EchoThenExit "Source Folder : ${folder} Not Exists!"
fi

# 目标文件夹
if [ -z "$target" ]
	then
	EchoThenExit "Please Input Target Folder!"
fi

if [ ! -d "$target" ]
	then
	EchoThenExit "Target Folder : ${target} Not Exists!"
fi

#失败文件
ErrorFiles=()
line=0

while read file
do
	line=`expr ${line} + 1`
	path="${folder}/${file}"
	if [ -d "$path" ]
		then
		filepath=${target}/${file%/*}
		if [ ! -d "$filepath" ]
			then
			mkdir -p "$filepath"
		fi
		cp -av  "${path}" "${target}/${file}"

	elif [ -f "$path" ]
		then

		gang="/"
		if [[ $file == *$gang* ]]
			then
			filepath=${target}/${file%/*}
			if [ ! -d "$filepath" ]
				then
				mkdir -p "$filepath"
			fi
		else
			filepath=${target}/${file}
		fi
		cp -av  "${path}" "${target}/${file}"

	else
		ErrorFiles[$line]="${folder}/${file}"
	fi
done < ./copyList.txt

echo "###############失败文件##################"
#输出失败文件
i=0
for t in "${ErrorFiles[@]}"
do
	i=`expr ${i} + 1`
	echo "${i} : 文件不存在 ${t}"
done
