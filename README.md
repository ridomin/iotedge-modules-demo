
# iotedge-modules

## Configure $edgehub locally

```bash
source .env
az login
az account set -s $SUB_ID
az iot hub device-identity create -n $HUB_ID -d $EDGE_ID --edge-enabled
az iot edge set-modules -n $HUB_ID -d $EDGE_ID -k deploy.json

dotnet tool install -g aziotedge-modinit

sasKey=$(az iot hub device-identity show -n $HUB_ID -d $EDGE_ID --query authentication.symmetricKey.primaryKey -o tsv)
aziotedge-modinit --ConnectionStrings:IoTEdge="HostName=$HUB_ID.azure-devices.net;DeviceId=$EDGE_ID;SharedAccessKey=$sasKey" --moduleId='$edgeHub'

az iot edge set-modules -n $HUB_ID -d $EDGE_ID -k deployBase.json

dotnet dev-certs https -ep _certs/localhost.pem --format PEM --no-password
chmod +r _certs/*
cp _certs/localhost.pem _certs/ca.pem

connStr=$(az iot hub module-identity connection-string show -n $HUB_ID -d $EDGE_ID -m '$edgeHub' --query connectionString -o tsv)
docker run -it --rm \
    -e IotHubConnectionString="$connStr" \
    -e EdgeModuleHubServerCertificateFile=/certs/localhost.pem \
    -e EdgeModuleHubServerCAChainCertificateFile=/certs/ca.pem \
    -e EdgeHubDevServerCertificateFile=/certs/localhost.pem \
    -e EdgeHubDevTrustBundleFile=/certs/ca.pem \
    -e EdgeHubDevServerPrivateKeyFile=/certs/localhost.key \
    -v $(pwd)/_certs:/certs \
    -p 8883:8883 \
    mcr.microsoft.com/azureiotedge-hub:1.4
```

## Create two modules using the dotnet template

```bash
dotnet new install Microsoft.Azure.IoT.Edge.Module
dotnet new aziotedgemodule -o ModuleA
dotnet new aziotedgemodule -o ModuleB
```    


