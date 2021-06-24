#! /bin/bash
CODE=$(curl -o /dev/null -s --max-time 2 -w "%{http_code}\n" http://$1:8080)
if [[ $CODE == "200" ]]; then
	exit 0
else
	echo "Request CODE:\t$CODE"
	exit 1
fi
