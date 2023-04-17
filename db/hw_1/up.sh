#!/bin/bash

script_dir="$(dirname $(dirname $(realpath $0)))/hw_1"
container_name="db_hw_1"

docker-compose -f $script_dir/compose.yml up -d

docker cp $script_dir/raw_csv/hw.csv $container_name:/docker-entrypoint-initdb.d/
docker cp $script_dir/raw_csv/coins.csv $container_name:/docker-entrypoint-initdb.d/
docker cp $script_dir/raw_csv/facilities.csv $container_name:/docker-entrypoint-initdb.d/

docker cp $script_dir/init.sql $container_name:/docker-entrypoint-initdb.d/