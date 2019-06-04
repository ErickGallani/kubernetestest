# Build all images
docker build -t erickgallani/fibonacci-multi-docker-test-client:latest -t erickgallani/fibonacci-multi-docker-test-client:$SHA ./client
docker build -t erickgallani/fibonacci-multi-docker-test-server:latest -t erickgallani/fibonacci-multi-docker-test-server:$SHA ./server
docker build -t erickgallani/fibonacci-multi-docker-test-worker:latest -t erickgallani/fibonacci-multi-docker-test-worker:$SHA ./worker

# Push images to docker hub
docker push erickgallani/fibonacci-multi-docker-test-client:latest
docker push erickgallani/fibonacci-multi-docker-test-server:latest
docker push erickgallani/fibonacci-multi-docker-test-worker:latest

docker push erickgallani/fibonacci-multi-docker-test-client:$SHA
docker push erickgallani/fibonacci-multi-docker-test-server:$SHA
docker push erickgallani/fibonacci-multi-docker-test-worker:$SHA

# apply the kubernetes configs
kubectl apply -f k8s


# imperative set the image to force kubernetes to re-build the nodes/pods
kubectl set image deployments/client-deployment client=erickgallani/fibonacci-multi-docker-test-client:$SHA
kubectl set image deployments/server-deployment server=erickgallani/fibonacci-multi-docker-test-server:$SHA
kubectl set image deployments/worker-deployment worker=erickgallani/fibonacci-multi-docker-test-worker:$SHA