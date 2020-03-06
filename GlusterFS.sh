#!/bin/bash

#主节点 192.168.1.12
#分节点 192.168.1.13、192.168.1.*

#添加yum源
yum -y install epel-release
yum -y install centos-release-gluster

#安装GlusterFS
yum -y install glusterfs glusterfs-fuse glusterfs-server

#启动服务并设置开机自启
systemctl start glusterd
systemctl enable glusterd

#添加磁盘到集群，各集群节点上的磁盘容量应该尽量相同（磁盘分区、创建文件系统、挂载）
#fdisk /dev/sdb
#mkfs.xfs /dev/sdb1
#mount /dev/sdb1 /data
#创建集群挂载点，由于不能使用磁盘的挂载点，因此需要在磁盘挂载点下新建挂载点
#mkdir /data/brick

#以上各节点都需要执行

#配置服务和集群
gluster peer probe 192.168.1.12
gluster peer probe 192.168.1.13

#查看集群状态
#gluster peer status

#创建GlusterFS卷
gluster volume create glusterfs_disk 192.168.1.12:/data/brick 192.168.1.13:/data/brick

#查看新建卷的情况
#gluster volume info

#启动磁盘
gluster volume start glusterfs_disk

#为磁盘设置访问权限
gluster volume set glusterfs_disk auth.allow 192.168.1.0/24

#在Linux中使用GlusterFS存储，需要安装GlusterFS相关软件包
#yum -y install glusterfs glusterfs-fuse

#挂载远程存储
# mount -t glusterfs 192.168.1.12:glusterfs_disk /mnt

#/etc/fstab
#192.168.1.12:glusterfs_disk  /mnt  glusterfs  defaults  0 0
