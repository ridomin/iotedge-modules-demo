source ../.env
az iot hub module-identity create -n $HUB_ID -d $EDGE_ID -m ModuleB