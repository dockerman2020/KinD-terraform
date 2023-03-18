#!/usr/bin/env sh

set -e

terraform apply -auto-approve

printf "\nWaiting for the echo web server service... \n"
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
sleep 10

printf "\nYou should see 'foo' as a reponse below (if you do the ingress is working):\n"
curl http://localhost/foo

# printf "\nInstalling Metallb LoadBalancer. Please wait:\n"
# kubectl apply -f /Volumes/LaCie/POC/MetalLB/metallb-native-v0139.yaml
