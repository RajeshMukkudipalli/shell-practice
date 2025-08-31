#!/bin/bash

# a=0

# while [ $a -lt 10 ]
# do
#     echo $a
#     a='expr $a + 1'
# done

while IFS= read -r line
do
    echo "$line"
done < 17-set.sh
# here IFS is internal field separator which is used to split the line into words and -r is used to prevent backslash from being interpreted as escape character
# < 17-set.sh is used to read the file line by line
# here while loop will read the file line by line and print each line
# IFS and -r are optional but it's a good practice to use them