# airflow-kubernetes

## Kubernetes Local Cluster

First of all, make sure that you have Docker installed in your machine, if you don't have Docker installed please head to Docker Desktop official page [here](https://www.docker.com/products/docker-desktop)

Go to Docker UI settings.

![windows-settings](https://i.ibb.co/PxkQ7T0/settings.png)

Click on 'Kubernetes' tab and enable kubernetes.

![docker-settings](https://i.ibb.co/DKB4wj1/dockersettings.png)

Wait for the Kubernetes to start and then install 'kubectl', to install kubectl you can follow the official documentation available [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Go to a terminal window and type the following command:

```bash
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
```

Then, if you are in bash type:

```bash
    kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
```

If you are in Windows, use a PowerShell window and type:

```bash
    kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | sls admin-user | ForEach-Object { $_ -Split '\s+' } | Select -First 1)
```

**!!!!! Copy the token generated !!!!!**

Type in your bash window:

```bash
    kubectl proxy
```

Kuberneted dashboard will be available at:

```link
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login
```

Select the token option, and paste the copied token.

## Deploying airflow to local cluster

Open a new bash window and type:

```bash
    kubectl create secret generic airflow-secrets --from-file=id_ed25519=$HOME/.ssh/id_ed25519 --from-file=knwon_hosts=$HOME/.ssh/known_hosts --from-file=$HOME/.ssh/id_ed25519.pub
```

Navigate to the repository that you have this repository and type:

```bash
    make variables && make deploy-airflow
```

More deploying options are available in the makefile.
