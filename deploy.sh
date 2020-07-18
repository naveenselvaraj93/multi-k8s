docker build -t naveenselvaraj93/mult-client:latest -t naveenselvaraj93/multi-client:$SHA -f ./client/Dcokerfile ./client
docker build -t naveenselvaraj93/mult-server:latest -t naveenselvaraj93/multi-server:$SHA -f ./server/Dcokerfile ./server
docker build -t naveenselvaraj93/multi-worker:latest -t naveenselvaraj93/multi-worker:$SHA -f ./worker/Dcokerfile ./worker

docker push naveenselvaraj93/multi-client:latest
docker push naveenselvaraj93/multi-worker:latest
docker push naveenselvaraj93/multi-server:latest

docker push naveenselvaraj93/multi-client:$SHA
docker push naveenselvaraj93/multi-worker:$SHA
docker push naveenselvaraj93/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naveenselvaraj93/multi-server:$SHA
kubectl set image deployments/client-deployment client=naveenselvaraj93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naveenselvaraj93/multi-worker:$SHA