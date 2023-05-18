import airflow
from datetime import timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator
from airflow.utils.dates import days_ago


default_args = {
    "owner": "airflow",
    #'start_date': airflow.utils.dates.days_ago(2),
    # 'end_date': datetime(),
    # 'depends_on_past': False,
    # 'email': ['airflow@example.com'],
    # 'email_on_failure': False,
    #'email_on_retry': False,
    # If a task fails, retry it once after waiting
    # at least 5 minutes
    #'retries': 1,
    "retry_delay": timedelta(minutes=5),
}

dag_spark = DAG(
    dag_id="a_sparkoperator_test",
    default_args=default_args,
    # schedule_interval='0 0 * * *',
    schedule_interval="@once",
    dagrun_timeout=timedelta(minutes=60),
    description="use case of sparkoperator in airflow",
    start_date=airflow.utils.dates.days_ago(0),
)

dummy_task = DummyOperator(task_id="dummy_task_", dag=dag_spark)
download_currency_rates = BashOperator(
    task_id="download_data",
    bash_command="wget https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD -O /data/us_electric_cars.csv",
)


spark_submit_local = SparkSubmitOperator(
    application="/root/airflow/dags/test_spark_app.py",
    conn_id="spark_default",
    task_id="spark_submit_task",
    dag=dag_spark,
    total_executor_cores=2,
    executor_cores=1,
    executor_memory="1g",
    driver_memory="1g",
)

dummy_task >> download_currency_rates >> spark_submit_local
