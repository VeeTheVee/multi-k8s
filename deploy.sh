docker build -t vikramtanwar/multi-client:latest -t vikramtanwar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vikramtanwar/multi-server:latest -t vikramtanwar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vikramtanwar/multi-worker:latest -t vikramtanwar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vikramtanwar/multi-client:latest
docker push vikramtanwar/multi-server:latest
docker push vikramtanwar/multi-worker:latest

docker push vikramtanwar/multi-client:$SHA
docker push vikramtanwar/multi-server:$SHA
docker push vikramtanwar/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vikramtanwar/multi-server:$SHA
kubectl set image deployments/client-deployment client=vikramtanwar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vikramtanwar/multi-worker:$SHA
