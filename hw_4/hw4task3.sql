CREATE OR REPLACE VIEW v_first_level_partition_info AS
    SELECT
        ns.nspname AS parent_schema,
        pc.relname AS parent_table,
        nc.nspname AS child_schema,
        cc.relname AS child_table
    FROM
        pg_namespace ns
        JOIN
        pg_class pc ON ns.oid = pc.relnamespace
        JOIN
        pg_inherits i ON pc.oid = i.inhparent
        JOIN
        pg_class cc ON i.inhrelid = cc.oid
        JOIN
        pg_namespace nc ON cc.relnamespace = nc.oid
    WHERE
        pc.relname = 'people_partitioned'
        AND
        nc.nspname NOT IN ('pg_catalog', 'information_schema')
        AND
        cc.relname LIKE 'people_partitioned_birthdays_%'