#!/bin/bash

dnf -y install dnf-plugins-core
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin -y
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

growpart /dev/nvme0n1p1 4
lvextend -L +20G /dev/RootVG/rootVol
lvextend -L +10G /dev/RootVG/varVol

xfs_growfs /
xfs_growfs /var