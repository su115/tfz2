#! /bin/bash

function testing(){

	CODE=$(curl -o /dev/null -s --max-time 2 -w "%{http_code}\n" $1)
	if [[ $CODE == "200" ]]; then
		echo "URL $1 is OK!"
	else
		echo "Request CODE: $CODE"
		echo "Bad URL: $1"
		exit 1
	fi
}



testing "http://$1:8080"
testing "http://$1:8080/SampleWebApp/"
