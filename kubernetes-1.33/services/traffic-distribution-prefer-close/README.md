Prerequisites: Kubernetes 1.33
or 1.30 with feature flag

# 1. create deployment with 2 receivers pods

```
kubectl create ns prefer-close
kubectl apply -f deploy.yaml
kubectl apply -f svc.yaml
```

Result:
2 pods on 2  differents nodes

```
$ kubectl get po -o wide

NAME                        READY   STATUS              RESTARTS   AGE   IP            NODE                         NOMINATED NODE   READINESS GATES
receiver-7cfd89d78d-dhv6z   1/1     Running             0          94s   10.240.4.91   my-pool-zone-c-wgrl6-slkq5   <none>           <none>
receiver-7cfd89d78d-hrxrt   1/1     Running             0          94s   10.240.5.63   my-pool-zone-a-b9ztj-mss8j   <none>           <none>
```

Create a pod and then issue a curl command to test loadbalancing of svc-prefer-close service:

```
$ kubectl run sender --image=curlimages/curl -it -- sh
If you don't see a command prompt, try pressing enter.
~ $ curl http://svc-prefer-close.prefer-close:8080
Hello, world!
Version: 2.0.0
Hostname: receiver-7cfd89d78d-gw7r9
```

kube-proxy should send the traffic from sender to a receiver-xx pod on the same node.

TODO: faire une copie de l'image docker, le pusher sur scraly docker hub pour afficher le node aussi ;-) 