echo "Airflow user=admin and password:"
docker exec -ti spark-submit cat /root/airflow/standalone_admin_password.txt
echo ""

echo "Update spark connection: Admin -> Connections -> spark_default"
echo "Host: spark://spark-master"
echo "Port: 7077"

docker exec -ti spark-submit airflow connections delete 'spark_default'
docker exec -ti spark-submit airflow connections add 'spark_default' \
    --conn-type 'spark' \
    --conn-host 'spark://spark-master' \
    --conn-port '7077' \
    --conn-extra '{"queue": "root.default"}' 

#echo "Run test spark dag"
#docker exec -ti spark-submit airflow dags trigger a_sparkoperator_test