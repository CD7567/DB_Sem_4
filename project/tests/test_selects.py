import os
import pytest
from . import execute_sql_to_df
from . import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    dfs = []
    for script in select_script.split(';')[:-1]:
        dfs.append(execute_sql_to_df(conn=sqlalchemy_conn, sql=script))
    return dfs


def test_0(select_df):
    df = select_df[0]
    assert df.shape[0] == 5
    assert df.query("price > 0").shape == df.shape


def test_1(select_df):
    df = select_df[1]
    assert df.shape[0] == 10
    assert df[df['client'].str.len() > 128].shape[0] == 0
    assert df[df['email'].str.contains(r'([A-Za-z0-9]+[.-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\.[A-Z|a-z]{2,})+$',
                                       regex=True)].shape == df.shape


def test_2(select_df):
    df = select_df[2]
    assert df.shape[0] == 10
    assert df.query('quantity > 0').shape == df.shape


def test_3(select_df):
    df = select_df[3]
    assert df.shape[0] == 60
    assert df[df['item_name'].str.len() > 128].shape[0] == 0
    assert df.query('price >= 0').shape == df.shape


def test_4(select_df):
    df = select_df[4]
    assert df.shape[0] == 10
    assert df.query('quantity <= total_quantity').shape == df.shape


def test_5(select_df):
    df = select_df[5]
    assert df.shape[0] == 10
    assert df[df['client'].str.len() > 128].shape[0] == 0
    assert df.query("balance >= 0").shape == df.shape
