source .env
connStr=$(az iot hub module-identity connection-string show -n $HUB_ID -d $EDGE_ID -m '$edgeHub' --query connectionString -o tsv)
docker run -it --rm \
    -e IotHubConnectionString="$connStr" \
    -e EdgeModuleHubServerCertificateFile=/certs/localhost.pem \
    -e EdgeModuleHubServerCAChainCertificateFile=/certs/ca.pem \
    -e EdgeHubDevServerCertificateFile=/certs/localhost.pem \
    -e EdgeHubDevTrustBundleFile=/certs/ca.pem \
    -e EdgeHubDevServerPrivateKeyFile=/certs/localhost.key \
    -v /workspaces/iotedge-modules-demo/_certs:/certs \
    -p 8883:8883 \
    mcr.microsoft.com/azureiotedge-hub:1.4