#!/bin/bash

# Get the number from the first command-line argument
num=$1

# Initialize factorial to 1
fact=1

# Loop from 1 up to the number
for (( i=1; i<=num; i++ ))
do
    # Multiply fact by the current loop variable
    (( fact=fact*i ))
done

# Print the result
echo "Factorial of $num is $fact"