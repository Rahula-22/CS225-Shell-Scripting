#!/bin/bash
# Assignment 2 - Question 1
# larger.sh - This script compares two files line by line and counts the number of common prefix.
# The result for each line pair is written to output.txt.

# Check if two files are provided and if both files exist.
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 file1 file2"
    exit 1
fi

if [ ! -f "$1" ] || [ ! -f "$2" ]; then
    echo "Usage: $0 file1 file2"
    echo " file1 and file2 should be text files containing the lines to compare."
    exit 1
fi

# Function to count the common prefix characters between two strings.
ccp() {
    local str1="$1"
    local str2="$2"
    local len=0
    # Minimum length of the two strings.
    local min_len=${#str1}
    if [ ${#str2} -lt $min_len ]; then
        min_len=${#str2}
    fi
    # Loop over each character so as to find the differences.
    for (( i=0; i<min_len; i++ )); do
        char1="${str1:$i:1}"
        char2="${str2:$i:1}"
        if [ "$char1" == "$char2" ]; then
            ((len++))
        else
            break
        fi
    done
    echo "$len"
}

#  Open the two files for reading. We use file descriptors 3 and 4 for the two files.
exec 3<"$1"
exec 4<"$2"

# output file.
result_file="result.txt"
> "$result_file"

# Reading both of the files line by line.
while true; do
    IFS= read -r line1 <&3
    status1=$?
    IFS= read -r line2 <&4
    status2=$?

    # If both files are done, exit the loop.
    if [ $status1 -ne 0 ] && [ $status2 -ne 0 ]; then
        break
    fi

    # If one file has more lines than the other, treat the missing line as an empty string.
    if [ $status1 -ne 0 ]; then
        line1=""
    fi
    if [ $status2 -ne 0 ]; then
        line2=""
    fi

    # Call the function and store the result.
    prefix_count=$(ccp "$line1" "$line2")
    echo "$prefix_count" >> "$result_file"
done
# Close file descriptors.
exec 3<&-
exec 4<&-
