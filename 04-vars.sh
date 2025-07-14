#! /bin/bash
#here $1 and $2 are positional parameters and we will pass them as arguments when we run the script
# Usage: ./04-vars.sh Trump Musk

person1=$1
person2=$2
echo "$person1: Hey $person2, How are you"
echo "$person2: Hey $person1, I am good. How are you?"
echo "$person1: I am good too. What are you doing these days?"
echo "$person2: I am working on my new project. What about you?"
echo "$person1: I am working on my new project too. What is your project about?"
echo "$person2: My project is about space travel. What about you?"
echo "$person1: My project is about making America great again."