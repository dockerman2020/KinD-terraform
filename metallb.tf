resource "null_resource" "install_metallb_loadbalancer" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Metallb installation to complete...\n"
      kubectl apply -f /Volumes/LaCie/POC/MetalLB/metallb-native-v0139.yaml
      kubectl apply -f /Volumes/LaCie/POC/MetalLB/metallb-native-v0139-IPpools.yaml
      kubectl wait --namespace metallb-system \
        --for=condition=ready pod \
        --selector=app=metallb \
        --timeout=30s
    EOF
  }


  depends_on = [helm_release.ingress_nginx]
}
