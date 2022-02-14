#!/bin/bash

API_ENDPOINT="https://api.quotable.io"
NL=$'\n'
DEFAULT="Hello $(whoami)! Have a great day!"
COLUMNS="$(tput cols)"

getRandomQuote() {
    # Get random quote
    RESPONSE=$(curl -s -m 5 $API_ENDPOINT/random)
    QUOTE=$(echo $RESPONSE | jq -r '.content')
    AUTHOR=$(echo $RESPONSE | jq -r '.author')

    # If the quote and author is not empty, show it
    if [ -n "$QUOTE" ] && [ -n "$AUTHOR" ]; then
        echo "$NL\"$QUOTE\" $NL- $AUTHOR"
    else
        echo "$NL$DEFAULT" | lolcat
    fi
}

# Check if the computer has internet connection
if ping -c 1 -w 1 google.com 2>&1 > /dev/null; then
    echo $(getRandomQuote) | lolcat
else
    # If it doesn't, show this
    echo "$NL$DEFAULT" | lolcat
fi