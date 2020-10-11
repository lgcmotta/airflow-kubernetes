variables:
	kubectl apply -f ./airflow/kubernetes/variables.yaml

remove-variables:
	kubectl delete -n default configMap airflow-cfgfile
	kubectl delete -n default configMap airflow-gitsync-dags
	kubectl delete -n default configMap airflow-gitsync-plugins
	kubectl delete -n default configMap airflow-known-hosts
	kubectl delete -n default configMap airflow-variables
	kubectl delete -n default configMap requirements-configmap

mysql:
	kubectl apply -f ./airflow/kubernetes/mysql.yaml

remove-mysql:
	kubectl delete -n default deployment mysql
	kubectl delete -n default service mysql
	kubectl delete -n default configMap mysql-config

redis:
	kubectl apply -f ./airflow/kubernetes/redis.yaml

remove-redis:
	kubectl delete -n default deployment redis
	kubectl delete -n default service redis

webserver:
	kubectl apply -f ./airflow/kubernetes/webserver.yaml

remove-webserver:
	kubectl delete -n default deployment airflow-webserver
	kubectl delete -n default service airflow-webserver
	kubectl delete -n default service airflow-webserver-web

scheduler:
	kubectl apply -f ./airflow/kubernetes/scheduler.yaml

remove-scheduler:
	kubectl delete -n default deployment airflow-scheduler

worker:
	kubectl apply -f ./airflow/kubernetes/worker.yaml

remove-worker:
	kubectl delete -n default deployment airflow-worker

flower:
	kubectl apply -f ./airflow/kubernetes/flower.yaml

remove-flower:
	kubectl delete -n default deployment airflow-flower
	kubectl delete -n default service airflow-flower

deploy-airflow:
	make flower
	make worker
	make scheduler
	make webserver

remove-airflow:
	make remove-flower
	make remove-worker
	make remove-scheduler
	make remove-webserver

deploy:
	make redis
	make mysql
	make deploy-airflow
	
delete-all:
	make remove-airflow
	make remove-mysql
	make remove-redis