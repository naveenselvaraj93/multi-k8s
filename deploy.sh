docker build -t naveenselvaraj/mult-client:latest -t naveenselvaraj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naveenselvaraj/mult-server:latest -t naveenselvaraj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naveenselvaraj/multi-worker:latest -t naveenselvaraj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naveenselvaraj/multi-client:latest
docker push naveenselvaraj/multi-worker:latest
docker push naveenselvaraj/multi-server:latest

docker push naveenselvaraj/multi-client:$SHA
docker push naveenselvaraj/multi-worker:$SHA
docker push naveenselvaraj/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naveenselvaraj/multi-server:$SHA
kubectl set image deployments/client-deployment client=naveenselvaraj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naveenselvaraj/multi-worker:$SHA