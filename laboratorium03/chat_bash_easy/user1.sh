#!/bin/bash

# check if enough arguments
if [[ $# != 2 ]]; then
	echo "Expected 2 arguments, got:" $#;
	echo "Try: ./script name1 name2 ...";
	exit
fi


function end() {
  echo -e "\nLeft the chat ...\n"
  kill -9 $(jobs -p) 2>/dev/null
  rm -rf /tmp/chat
}


# check if we need to create folder
if (( `ls /tmp | grep chat | wc -l` == 0 )); then
  mkdir /tmp/chat
fi

# creating name pipes
P1=/tmp/chat/chatpipe${1}
P2=/tmp/chat/chatpipe${2}

[ -p "$P1" ] || mkfifo $P1 
[ -p "$P2" ] || mkfifo $P2 

echo -e "Created pipes:\n"`ls /tmp/chat | grep chatpipe`
echo ""

# end it gently
trap end EXIT

echo -e "Welcome to super easy chat room\n"

# read p2 
(cat $P2 | sed "s/^/${2}> /") &

# print info about user that joined
(echo "$1 joined"; cat) >> $P1

# end it gently
trap end EXIT
