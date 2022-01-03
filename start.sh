#!/bin/bash

cd database

docker network rm velcom_net
docker network create velcom_net

bash ./build-and-test-velcom.sh

sleep 10
git commit -s
cd ..
cd midware
bash ./build-and-test-velcom.sh