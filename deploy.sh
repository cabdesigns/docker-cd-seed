#!/bin/bash

# Exit on any error
set -e

sudo /opt/google-cloud-sdk/bin/gcloud docker push ${CONTAINER_REGISTRY}/${PROJECT_NAME}
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
kubectl patch deployment ${CONTAINER_NAME} -p '{"spec":{"template":{"spec":{"containers":[{"name":"'"$CONTAINER_NAME"'","image":"'"$CONTAINER_REGISTRY"'/'"$PROJECT_NAME"':'"$CIRCLE_SHA1"'"}]}}}}'
