# CS225-Shell-Scripting
This repository contains my solutions for the CS253 shell scripting assignment. The project includes two main shell scripts—`larger.sh` and `main.sh`—that automate text processing and log analysis tasks by utilizing common shell utilities such as `sed`, `grep`, `awk`, as well as output redirection methods.

## Project Overview

The assignment consists of two main tasks, each implemented in a separate shell script:

### 1. larger.sh
The `larger.sh` script performs the following tasks:
- **Input Validation:** It accepts two file names as input. If either file does not exist, it prints a usage message explaining how to run the script and then exits.
- **Prefix Comparison:** The script reads both input files line-by-line and calculates the number of common characters (prefix) at the beginning of the corresponding lines.
- **Output:** The count for each pair of lines is written to an output file.

For example, given:
- **file1.txt:**
- **file2.txt:**

### 2. main.sh
The `main.sh` script is designed for log analysis. It processes a CSV file (`logs.csv`) containing log entries and performs the following tasks:
- **Unique IP Extraction:** Extracts and prints the unique IP addresses from the `logs.csv` file to an output file.
- **Top 3 HTTP Methods:** Identifies the top 3 HTTP methods (e.g., GET, POST, etc.) used in the dataset, and writes their names along with their frequencies to the output file.
- **Hourly Request Count:** Counts the total number of requests made in each hour of the day (0-23) and saves the results in a human-friendly format:

- **Execution Logging:** Throughout its execution, the script appends timestamps and descriptive labels (e.g., “Input file exists”, “Unique IP extraction completed”, etc.) to a log timestamp file (e.g., `log_ts.txt`), providing a clear record of its execution steps.

## File Structure

- **larger.sh:**  
Script to compare two input files line-by-line for common prefix counts.

- **main.sh:**  
Script to analyze log data from a CSV file. It extracts unique IP addresses, identifies the top 3 HTTP methods, counts hourly requests, and logs its execution steps.

- **logs.csv:**  
Sample CSV log file. *Note: Ensure that this file is present in the same directory as the scripts when you run them.*

## Usage Instructions

### Running larger.sh
To run the `larger.sh` script, open a terminal in the repository directory and run:
```bash
bash larger.sh file1.txt file2.txt

Prerequisites
A Unix-like operating system (Linux, macOS, or Windows Subsystem for Linux).Bash shell.
Standard Unix utilities (sed, grep, awk) available in your environment.

Running main.sh
To run the main.sh script, use the following command: bash main.sh logs.csv output.txt log_ts.txt
