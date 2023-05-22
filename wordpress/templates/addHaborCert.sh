sudo scp vagrant@192.168.50.100:/etc/ssl/certs/ca.crt /etc/ssl/certs/caHarbor.crt
sudo cp /etc/ssl/certs/caHarbor.crt /usr/local/share/ca-certificates/
sudo mkdir -p /var/lib/containerd/tls/
sudo cp /etc/ssl/certs/caHarbor.crt /var/lib/containerd/tls/
sudo chmod 644 /var/lib/containerd/tls/caHarbor.crt
sudo systemctl restart containerd
sudo update-ca-certificates
