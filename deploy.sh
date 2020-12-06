docker build -t guillermoargandona/multi-client:latest -t guillermoargandona/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t guillermoargandona/multi-server:latest -t guillermoargandona/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t guillermoargandona/multi-worker:latest -t guillermoargandona/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push guillermoargandona/multi-client:latest
docker push guillermoargandona/multi-server:latest
docker push guillermoargandona/multi-worker:latest

docker push guillermoargandona/multi-client:$SHA
docker push guillermoargandona/multi-server:$SHA
docker push guillermoargandona/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=guillermoargandona/multi-server:$SHA
kubectl set image deployments/client-deployment client=guillermoargandona/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=guillermoargandona/multi-worker:$SHA