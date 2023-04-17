#!/bin/bash

project_dir="$(dirname $(dirname $(realpath $0)))"
container_name="db_project"

docker-compose -f $project_dir/docker/compose.yml up -d

docker cp $project_dir/scripts/init.sql $container_name:/docker-entrypoint-initdb.d/
docker cp $project_dir/scripts/ddl.sql $container_name:/home/
docker cp $project_dir/scripts/queries.sql $container_name:/home/

sleep 1

docker exec $container_name psql postgres -U postgres -f /home/ddl.sql
docker exec $container_name psql postgres -U postgres -f /home/queries.sql

#docker cp $script_dir/raw_csv/members.csv $container_name:/docker-entrypoint-initdb.d/
#docker cp $script_dir/raw_csv/facilities.csv $container_name:/docker-entrypoint-initdb.d/
#docker cp $script_dir/raw_csv/bookings.csv $container_name:/docker-entrypoint-initdb.d/

#docker cp $script_dir/init.sql $container_name:/docker-entrypoint-initdb.d/