$script = <<-SCRIPT
sudo apt-get update

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl


sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl net.ipv4.ip_forward=1

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

SCRIPT








Vagrant.configure("2") do |config|

  # Configuration du master
  config.vm.provision "shell", inline: $script 
  config.vm.define "master" do |master|
    master.vm.box = "bento/ubuntu-20.04"
    master.vm.hostname = "k8s-master"
    master.vm.network "private_network", ip: "192.168.50.10"
    master.vm.synced_folder "/Users/pierrickdelrieu/Desktop/k8s", "/sharedWithPC"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "master"
    end
  end


  # Configuration des workers
  (1..2).each do |i|
    config.vm.provision "shell", inline: $script 
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "bento/ubuntu-20.04"
      worker.vm.hostname = "k8s-worker#{i}"
      worker.vm.network "private_network", ip: "192.168.50.1#{i}"
      worker.vm.synced_folder "/Users/pierrickdelrieu/Desktop/k8s", "/sharedWithPC"
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
        vb.name = "worker#{i}"
      end
    end
  end


  # Configuration du vm de service
  config.vm.provision "shell", inline: $script 
  config.vm.define "services" do | services |
    services.vm.box = "bento/ubuntu-20.04"
    services.vm.hostname = "k8s-services"
    services.vm.network "private_network", ip: "192.168.50.100"
    services.vm.synced_folder "/Users/pierrickdelrieu/Desktop/k8s", "/sharedWithPC"
    services.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "services"
    end
  end
end
