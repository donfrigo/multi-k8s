docker build -t donfrigo/multi-client:latest -t donfrigo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t donfrigo/multi-server:latest -t donfrigo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t donfrigo/multi-worker -t donfrigo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push donfrigo/multi-client:latest
docker push donfrigo/multi-server:latest
docker push donfrigo/multi-worker:latest
docker push donfrigo/multi-client:$SHA
docker push donfrigo/multi-server:$SHA
docker push donfrigo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=donfrigo/multi-server:$SHA
kubectl set image deployments/client-deployment client=donfrigo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=donfrigo/multi-worker:$SHA