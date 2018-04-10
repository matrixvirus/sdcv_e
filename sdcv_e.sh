#!/bin/bash
function interactMode()
{
# 交互模式，循环查词，当命令没有跟参数时使用。
	echo "记住查qq这个单词启以退出我"
	local word=""
	while [ "$word" != "qq" ]
	do
		read -p "请输入单词: " word
		if [ "$word" = "qq" ]
		then
			break
		fi
		sdcv "$word" -n | less
		# sdcv 的-n参数意思是不交互，比如你查qq，这个单词并不存在，正常情况
		# sdcv 会列出各个字典中与qq接近的词，并允许你通过输入数字来选择要查
		# 看哪个与qq接近的词的详细解释，加了-n后，sdcv直接列出所有字典中与qq
		# 接近的词的解释，不再提供选择。
	done
	echo -e "\e[5;36m谢谢使用\e[0m"
	# \e[5;36m 意思是使用莹蓝色，闪烁字，5是闪烁，36是莹蓝色。
	
}
function staticMode()
{
# 只查命令参数里指定的几个单词，然后退出。
	local word=""
	while [ $# -gt 0 ]
	do
		word=$1
		sdcv "$word" -n | less
		shift
	done
}
case $# in
0)
	interactMode
	;;
*)
	staticMode $@
	;;	
esac
