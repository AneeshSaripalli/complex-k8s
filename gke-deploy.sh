docker build -t aneeshsaripalli/multi-client:latest -t aneeshsaripalli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aneeshsaripalli/multi-server:latest -t aneeshsaripalli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aneeshsaripalli/multi-worker:latest -t aneeshsaripalli/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aneeshsaripalli/multi-client:latest 
docker push aneeshsaripalli/multi-server:latest
docker push aneeshsaripalli/multi-worker:latest

docker push aneeshsaripalli/multi-client:$SHA 
docker push aneeshsaripalli/multi-server:$SHA
docker push aneeshsaripalli/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=aneeshsaripalli/multi-client:$SHA
kubectl set image deployments/server-deployment server=aneeshsaripalli/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=aneeshsaripalli/multi-worker:$SHA
