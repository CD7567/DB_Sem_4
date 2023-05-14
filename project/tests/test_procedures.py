import os
import pytest
from . import execute_sql_to_df
from . import psycopg2_execute_sql
from . import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    dfs = []

    for script in select_script.split('--'):
        if 'CALL' in script:
            psycopg2_execute_sql(conn=sqlalchemy_conn, sql=script)
        else:
            dfs.append(execute_sql_to_df(conn=sqlalchemy_conn, sql=script))
    return dfs


def test_0(select_df):
    df_trans_old = select_df[0]
    df_cw_old = select_df[1]
    df_cwh_old = select_df[2]
    
    df_trans_new = select_df[3]
    df_cw_new = select_df[4]
    df_cwh_new = select_df[5]

    assert df_trans_old.shape[0] + 2 == df_trans_new.shape[0]
    assert df_cwh_old.shape[0] + 2 == df_cwh_new.shape[0]

    assert df_cw_old.query("id = 1") == df_cw_new.query("id = 1")


def test_1(select_df):
    df_of_old = select_df[6]
    df_ofc_old = select_df[7]
    
    df_of_new = select_df[8]
    df_ofc_new = select_df[9]

    assert df_of_old.shape[0] + 1 == df_of_new.shape[0]
    assert df_ofc_old.shape[0] + 2 == df_ofc_new.shape[0]

