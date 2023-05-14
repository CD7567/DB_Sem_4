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
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select_script
    )


def test(select_df):
    assert select_df.query("table_name == 'clients'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'shops'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'items'")['cnt'].iloc[0] == 35
    assert select_df.query("table_name == 'items_info'")['cnt'].iloc[0] == 60
    assert select_df.query("table_name == 'offers'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'offers_content'")['cnt'].iloc[0] == 26
    assert select_df.query("table_name == 'transactions'")['cnt'].iloc[0] == 13
    assert select_df.query("table_name == 'transactions_content'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'clients_history'")['cnt'].iloc[0] == 13
    assert select_df.query("table_name == 'clients_wallet'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'clients_wallet_history'")['cnt'].iloc[0] == 14