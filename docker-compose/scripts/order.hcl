path "secret/spring-vault-demo*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "secret/application*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "transit/decrypt/order" {
  capabilities = ["update"]
}
path "transit/encrypt/order" {
  capabilities = ["update"]
}
path "database/creds/order" {
  capabilities = ["read"]
}
path "sys/renew/*" {
  capabilities = ["update"]
}