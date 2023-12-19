source ../.env
connStr=$(az iot hub module-identity connection-string show -n $HUB_ID -d $EDGE_ID -m ModuleB --query connectionString -o tsv)
IotHubConnectionString="$connStr;GatewayHostName=localhost"
EdgeModuleCACertificateFile="../_certs/ca.pem"
dotnet run
