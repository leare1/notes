#!/bin/bash
# download k8s 1.17.2 images
# get image-list by 'kubeadm config images list --kubernetes-version=v1.17.2'
# gcr.azk8s.cn/google-containers == k8s.gcr.io

images=(
kube-apiserver:v1.17.2
kube-controller-manager:v1.17.2
kube-scheduler:v1.17.2
kube-proxy:v1.17.2
pause:3.1
etcd:3.4.3-0
coredns:1.6.5
)

for imageName in ${images[@]};do
    docker pull gcr.azk8s.cn/google-containers/$imageName  
    docker tag  gcr.azk8s.cn/google-containers/$imageName k8s.gcr.io/$imageName  
    docker rmi  gcr.azk8s.cn/google-containers/$imageName
done
