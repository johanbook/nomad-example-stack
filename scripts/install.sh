# /bin/sh
# See docs at https://www.nomadproject.io/docs/integrations/consul-connect

curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v1.0.0.tgz
sudo mkdir -p /opt/cni/bin
sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz

echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-arptables
echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-ip6tables
echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables
