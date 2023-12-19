source ../.env
connStr=$(az iot hub device-identity connection-string show -n $HUB_ID -d $EDGE_ID --query connectionString -o tsv)
echo $connStr
aziotedge-modinit --ConnectionStrings:IoTEdge="$connStr" --moduleId=ModuleA