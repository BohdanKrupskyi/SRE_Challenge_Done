I have created the folder on my local device and split the nginx file in two:
* nginx_service_fix.yaml
* nginx_deployment_fix.yaml
 Run:
$ minikube start
$ kubectl create -f nginx_service_fix.yaml
then I run
$ kubectl get pods                   and noticed that is constantly in Pending status

I changed the service file values from:
selector:
  app: sretest-service

To

selector:
  app: sretest



  Run such command to make nodeAffininty row working:
kubectl label nodes minikube node-role.kubernetes.io/application=sretest




Also, made some lower limits as was facing some critical loop errors in pod status:
resources:
  limits:
    cpu: 2  # Lowering the CPU limit
    memory: 128Mi
  requests:
    cpu: 1  # Lowering the CPU request
    memory: 64Mi
