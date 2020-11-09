#!/bin/sh
IFS=$'\n\t'

# If any cli arg has been passed
# Read more in https://www.linuxtechi.com/command-line-arguments-in-linux-shell-scripting/
if [[ $# -gt 0 ]]; then
	RARS=$1
else
#	ls *.jar -> list all jar files

#	grep -i rars -> match, case insensitive,
#	'rars' containing lines

#	head -n 1 -> filter first line
	RARS=$(ls *.jar | grep -i rars | head -n 1)
fi

# 'nohup' -> detach the process from the terminal
# (you can end your shell session or close your
# terminal without killing the process)

# '1>/dev/null' -> to redirect stdout(1, can be ommited) to file(>) /dev/null
# (suppresses output to the terminal, dump to null)

# '2>&1' -> to redirect stderr(2) to stream(>&) stdout(1)
# Read more in https://stackoverflow.com/questions/818255/in-the-shell-what-does-21-mean#answers-header

# '&' -> run the command in the background
# (so your shell isn't blocked)

nohup java -jar $RARS 1>/dev/null 2>&1 &
