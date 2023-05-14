#!/bin/bash

project_dir="$(dirname $(dirname $(realpath $0)))"
container_name="db_project"

BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'


echo -e "$BLUE[Stage] Closing running container if exists$NC"


docker stop $container_name
docker rm $container_name



echo -e "$BLUE[Stage] Composing container$NC"
docker-compose -f $project_dir/docker/compose.yml up -d



echo -e "$BLUE[Stage] Copying database scripts$NC"

docker exec $container_name mkdir /home/init /home/queries /home/testing_queries

docker cp $project_dir/scripts/ddl.sql $container_name:/home/init/
docker cp $project_dir/scripts/views.sql $container_name:/home/init/
docker cp $project_dir/scripts/procedures.sql $container_name:/home/init/

docker cp $project_dir/scripts/dml.sql $container_name:/home/init/

docker cp $project_dir/scripts/queries.sql $container_name:/home/queries/

docker cp $project_dir/scripts/select_count_tables.sql $container_name:/home/testing_queries/
docker cp $project_dir/scripts/selects.sql $container_name:/home/testing_queries/
docker cp $project_dir/scripts/select_views.sql $container_name:/home/testing_queries/
docker cp $project_dir/scripts/select_procedures.sql $container_name:/home/testing_queries/



sleep 3



echo -e "$BLUE[Stage] Running init scripts$NC"


echo -e "$CYAN[INFO] Running ddl.sql$NC"
docker exec $container_name psql postgres -U postgres -f /home/init/ddl.sql

echo -e "$CYAN[INFO] Running dml.sql$NC"
docker exec $container_name psql postgres -U postgres -f /home/init/dml.sql

echo -e "$CYAN[INFO] Running views.sql$NC"
docker exec $container_name psql postgres -U postgres -f /home/init/views.sql

echo -e "$CYAN[INFO] Running procedures.sql$NC"
docker exec $container_name psql postgres -U postgres -f /home/init/procedures.sql


# echo -e "$BLUE[Stage] Running queries$NC"


# echo -e "$CYAN[INFO] Running queries.sql$NC"
# docker exec $container_name psql postgres -U postgres -f /home/queries.sql



echo -e "$BLUE[Stage] Running testing queries$NC"


# echo -e "$CYAN[INFO] Running select_count_tables.sql$NC"
# docker exec $container_name psql postgres -U postgres -f /home/testing_queries/select_count_tables.sql

# echo -e "$CYAN[INFO] Running selects.sql$NC"
# docker exec $container_name psql postgres -U postgres -f /home/testing_queries/selects.sql

# echo -e "$CYAN[INFO] Running select_views.sql$NC"
# docker exec $container_name psql postgres -U postgres -f /home/testing_queries/select_views.sql

echo -e "$CYAN[INFO] Running select_procedures.sql$NC"
docker exec $container_name psql postgres -U postgres -f /home/testing_queries/select_procedures.sql