# Vault Java App Demo
  
# Run

```shell
# export Vault license
export VAULT_LICENSE=$(cat ~/Downloads/vault.hclic)     

# Start all containers and minikube
make all

# Login to Vault as admin
export VAULT_ADDR=http://localhost:8200
vault login --method=userpass username=admin password=passw0rd
```

# Useful commands
```shell

# login to mysql and show table schema
docker exec -it mysql sh
mysql -uroot -ppassw0rd
use demo;
describe orders;

# build demo-api spring boot app
make build-api

# run demo-api spring boot app locally
make run-api

# build demo-api app docker image
make build-docker-api

```

# Reference
- [Vault Java Application Demo Tutorial](https://developer.hashicorp.com/vault/tutorials/encryption-as-a-service/eaas-spring-demo)
- [Refreshing Spring Configuration at runtime](https://cloud.spring.io/spring-cloud-static/Greenwich.RELEASE/multi/multi__spring_cloud_config_2.html#_refreshing_the_configuration_at_runtime)