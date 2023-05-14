CREATE OR REPLACE VIEW v_first_level_partition_info AS
    SELECT  parent_namespace.nspname AS parent_schema,
        parent.relname AS parent_table,
        child_namespace.nspname AS child_schema,
        child.relname AS child_table
    FROM
        pg_inherits
        JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
        JOIN pg_namespace parent_namespace ON parent.relnamespace = parent_namespace.oid
        JOIN pg_class child ON pg_inherits.inhrelid = child.oid
        JOIN pg_namespace child_namespace ON child.relnamespace = child_namespace.oid;

CREATE OR REPLACE RECURSIVE VIEW v_rec_level_partition_info (part_level, parent_schema, parent_table, child_schema, child_table) AS
    SELECT 1 AS part_level, *
        FROM v_first_level_partition_info
    UNION ALL
    SELECT part_level + 1 AS part_level, parent.parent_schema, parent.parent_table, child.child_schema, child.child_table
        FROM
            v_rec_level_partition_info child
            JOIN v_first_level_partition_info parent
            ON child.parent_schema = parent.child_schema and child.parent_table = parent.child_table;
