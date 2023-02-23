#!/bin/bash
set -euo pipefail

export VAULT_INIT_OUTPUT=vault.json

tput setaf 12 && echo "############## Initializing Vault ##############"
export VAULT_ADDR=http://localhost:8200
sleep 5
vault operator init -format=json -n 1 -t 1 > ${VAULT_INIT_OUTPUT}

export VAULT_TOKEN=$(cat ${VAULT_INIT_OUTPUT} | jq -r '.root_token')
tput setaf 12 && echo "############## Root VAULT TOKEN is: $VAULT_TOKEN ##############"

tput setaf 12 && echo "############## Unseal Vault ##############"
export VAULT_ADDR=http://localhost:8200

export unseal_key=$(cat ${VAULT_INIT_OUTPUT} | jq -r '.unseal_keys_b64[0]')
vault operator unseal ${unseal_key}

tput setaf 12 && echo "############## Vault Cluster members ##############"
vault operator members

export VAULT_TOKEN=$(cat ${VAULT_INIT_OUTPUT} | jq -r '.root_token')

tput setaf 12 && echo "############## Configure polices on Vault ##############"

vault policy write admin ./admin_policy.hcl

tput setaf 12 && echo "############## Enable userpass auth on Vault ##############"

vault auth enable -max-lease-ttl=1h userpass

vault write auth/userpass/users/admin password="passw0rd" policies="admin"

tput setaf 12 && echo "############## Enable audit device ##############"

vault audit enable file file_path=/var/log/vault/vault-audit.log mode=744

tput setaf 12 && echo "############## Setup Database secret engine ##############"

vault secrets enable database

vault write database/roles/demoapp \
db_name=mysql-demo-db \
creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT,INSERT,UPDATE ON demo.users_tokenization TO '{{name}}'@'%';" \
default_ttl="8h" \
max_ttl="8h"

vault write database/config/mysql-demo-db \
plugin_name=mysql-legacy-database-plugin \
connection_url="{{username}}:{{password}}@tcp(mysql:3306)/" \
allowed_roles="spring-demo-app" \
username="root" \
password="passw0rd"

tput setaf 12 && echo "############## Setup Transit secret engine ##############"

vault secrets enable transit

vault write -f transit/keys/my-key

tput setaf 12 && echo "############## Please Run: export VAULT_TOKEN=${VAULT_TOKEN} ##############"