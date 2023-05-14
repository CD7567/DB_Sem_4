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
    assert df[df["phone"].str.len() > 32].shape[0] == 0
    assert df[df["email"].str.len() > 128].shape[0] == 0
    assert df[df["phone"].str.contains(r'\+\d-\(\*{3}\)-\*{3}-\d{2}-\d{2}', regex=True)].shape == df.shape
    assert df[df["email"].str.contains(r'\**@\w+?\.\w+?$', regex=True)].shape == df.shape

def test_1(select_df):
    df = select_df[1]
    assert df[df["item_name"].str.len() > 256].shape[0] == 0
    assert df[df["shop_name"].str.len() > 128].shape[0] == 0
    assert df.query("price > 0").shape == df.shape
    assert df.query("avg_price > 0").shape == df.shape

def test_2(select_df):
    df = select_df[2]
    assert df.query("total_bonuses >= 0").shape == df.shape
    assert df.query("upd_balance >= 0").shape == df.shape

def test_3(select_df):
    df = select_df[3]
    assert df.query("total_bonuses >= 0").shape == df.shape
    assert df.query("quantity > 0").shape == df.shape
    assert df.query("bonus_count > 0").shape == df.shape

def test_4(select_df):
    df = select_df[4]
    assert df[df["shop_name"].str.len() > 128].shape[0] == 0
    assert df[df["item_name"].str.len() > 256].shape[0] == 0
    assert df[df["manufacturer"].str.len() > 256].shape[0] == 0
    assert df[df["vendor_code"].str.len() > 128].shape[0] == 0
    assert df[df["category"].str.len() > 128].shape[0] == 0
    assert df.query("price > 0").shape == df.shape

def test_5(select_df):
    df = select_df[5]
    assert df[df["client"].str.len() > 129].shape[0] == 0
    assert df.query("pause_count >= 0").shape == df.shape
    assert df.query("leave_count >= 0").shape == df.shape
