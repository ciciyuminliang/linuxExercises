#!/bin/bash

sum=0

for num in {1000..2000}
do
    # Check if the number contains only digits 0 and 1
    if [[ $num =~ ^[01]+$ ]]; then
        sum=$((sum + num))
    fi
done

# Output
echo "The sum of numbers between 1000 and 2000 with digits only from {0, 1} is: $sum"
