#!/bin/sh
SENSORS="LIDAR_01 LIDAR_02 LIDAR_03 CAM_FRONT RADAR_REAR"
STATUSES="[INFO] FRAME_OK [WARN] DROPPED_FRAME [INFO] SYNC_OK"

for i in $(seq 1 5000); do
    S=$(echo $SENSORS | tr ' ' '\n' | shuf -n 1)
    ST=$(echo $STATUSES | tr ' ' '\n' | shuf -n 1)
    echo "$(date +"%Y-%m-%d %H:%M:%S") $ST sensor_id=$S frame_index=$i"
done > sensor_log.txt
