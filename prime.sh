#!/bin/bash

echo "Enter a number:"
read number

# Handle numbers less than 2 (0, 1, negative numbers)
if [ "$number" -lt 2 ]; then
  echo "$number is not a prime number."
  exit 0
fi

# Check for divisibility from 2 up to the square root of the number
# Using bc for floating point calculations to get the square root
max=$(echo "sqrt($number)" | bc)

i=2
is_prime=1 # Flag: 1 for prime, 0 for not prime

while [ "$i" -le "$max" ]; do
  if [ $((number % i)) -eq 0 ]; then
    is_prime=0
    break # Not prime, no need to check further
  fi
  i=$((i + 1))
done

if [ "$is_prime" -eq 1 ]; then
  echo "$number is a prime number."
else
  echo "$number is not a prime number."
fi