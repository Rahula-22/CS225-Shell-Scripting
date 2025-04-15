#!/bin/bash
# Assignment 2: Question 2
# main.sh:
#(a) It extract unique IP addresses and write them to the output file.
#(b) Identify the top 3 HTTP methods and write their names and frequencies.
#(c) It count the total number of requests per hour and write the results.

export TZ="Asia/Kolkata" # For Asia/kolkata Timezone

# Check if three three are there or not.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 logs.csv output.txt log_ts.txt"
  exit 1
fi

input_file="$1"
output_file="$2"
log_ts_file="$3"

# Function to log steps with timestamps
log_message() {
  local message="$1"
  echo "$(TZ='Asia/Kolkata' date +"%Y-%m-%d %H:%M:%S") - $message" >> "$log_ts_file"
}

# Check if input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: Input file $input_file not found."
  log_message "Input file not detected"
  exit 1
fi

log_message "Input file exists"

# Clear output file before writing
> "$output_file"

# (a) Extract Unique IPs
# Skip CSV header using NR>1 in awk if exists and extract the 1st field (IP address)
awk -F',' 'NR>1 {print $1}' "$input_file" | sort -u >> "$output_file"

log_message "Unique IP extraction completed"

# (b) Identify the top 3 HTTP Methods
# Extract HTTP methods (3rd field) and count frequencies
echo -e "\nTop 3 HTTP Methods:" >> "$output_file"
awk -F',' 'NR>1 {print $3}' "$input_file" | sort | uniq -c | sort -nr | head -3 | awk '{print $2 ": " $1 " times"}' >> "$output_file"

log_message "top 3 HTTP methods identified"

# Format: YYYY-MM-DD HH:MM:SS.
# (c) Hourly Request Count (0-23)
# Convert UTC timestamps from the CSV to IST and count the requests per hour.
echo -e "\nHourly Request Count:" >> "$output_file"
awk -F',' 'NR>1 {
    cmd = "TZ=Asia/Kolkata date -d \"" $2 " UTC\" +\"%H\""
    cmd | getline ist_hour
    close(cmd)
    counts[ist_hour]++
}
END {
    for(i = 0; i < 24; i++) {
        printf "Hour %02d: %d requests\n", i, (i in counts ? counts[i] : 0)
    }
}' "$input_file" >> "$output_file"

log_message "Hourly request count completed"
log_message "Script execution completed"

echo "Processing done. All results are saved"
