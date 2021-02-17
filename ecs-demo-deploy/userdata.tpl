#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${cluster_name}" >> /etc/ecs/ecs.config