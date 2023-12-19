source ../.env
connStr=$(az iot hub module-identity connection-string show -n $HUB_ID -d $EDGE_ID -m ModuleA --query connectionString -o tsv)
export IotHubConnectionString="$connStr;GatewayHostName=localhost"
export EdgeModuleCACertificateFile="../_certs/ca.pem"
dotnet run
