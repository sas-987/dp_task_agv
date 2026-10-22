#!/bin/sh

# Set the input log file path (accepts argument or defaults to sensor_log.log)
LOG_FILE="${1:-sensor_log.log}"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found." >&2
    exit 1
fi

# Pipeline process:
# 1. grep: Filter lines matching '[WARN] DROPPED_FRAME'
# 2. awk: Extract the sensor ID field dynamically
# 3. sort: Sort alphabetically to prepare for uniq counting
# 4. uniq -c: Count occurrences for each unique sensor ID
# 5. sort -nr: Sort numerical count in descending order
grep '\[WARN\] DROPPED_FRAME' "$LOG_FILE" | \
awk '{
    for (i=1; i<=NF; i++) {
        if ($i ~ /^sensor_id=/) {
            split($i, a, "=");
            print a[2];
        }
    }
}' | \
sort | \
uniq -c | \
sort -nr | \
awk '{print $2 ": " $1 " drops"}'
