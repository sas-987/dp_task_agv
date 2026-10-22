#!/bin/sh


LOG_FILE="${1:-sensor_log.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found." >&2
    exit 1
fi

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
