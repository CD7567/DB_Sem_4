CREATE OR REPLACE VIEW v_first_level_partition_info (
    parent_schema,
    parent_table,
    child_schema,
    child_table
) AS (
    SELECT
        pan.nspname,
        pa.relname,
        chan.nspname,
        ch.relname
    FROM
        pg_inherits AS inh
        JOIN
        pg_class AS ch ON (inh.inhrelid = ch.oid)
        JOIN
        pg_class AS pa ON (inh.inhparent = pa.oid)
        JOIN
        pg_namespace AS chan ON (ch. relnamespace = chan.oid)
        JOIN
        pg_namespace AS pan ON (pa.relnamespace = pan.oid)
);


CREATE OR REPLACE RECURSIVE VIEW v_rec_level_partition_info (
    parent_schema,
    parent_table,
    child_schema,
    child_table,
    part_level
) AS (
    SELECT
        parent_schema,
        parent_table,
        child_schema,
        child_table,
        1 AS part_level
    FROM v_first_level_partition_info
    UNION
    SELECT
        prev.parent_schema,
        prev.parent_table,
        inh.child_schema,
        inh.child_table,
        prev.part_level + 1
    FROM
        v_first_level_partition_info AS inh
        JOIN
        v_rec_level_partition_info AS prev
        ON (
            inh.parent_schema = prev.child_schema
            AND
            inh.parent_table = prev.child_table
        )
);


CREATE OR REPLACE VIEW v_used_size_per_user (
    table_owner,
    schema_name,
    table_name,
    table_size,
    used_per_schema_user_total_size,
    used_user_total_size
) AS (
    SELECT
        tableowner AS table_owner,
        schemaname AS schema_name,
        tablename AS table_name,
        pg_size_pretty(tablesize) AS table_size,
        pg_size_pretty(SUM(tablesize) OVER (PARTITION BY tableowner, schemaname)) AS used_per_schema_user_total_size,
        pg_size_pretty (SUM(tablesize) OVER (PARTITION BY tableowner)) AS used_user_total_size
    FROM (
        SELECT
            tableowner,
            schemaname,
            tablename,
            pg_relation_size('"' ||schemaname||'"."' ||tablename||'"') AS tablesize
        FROM pg_tables
    ) AS table_data
);