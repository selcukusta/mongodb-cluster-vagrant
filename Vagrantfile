
# -*- mode: ruby -*-
# vi: set ft=ruby :

### configuration parameters
BOX_BASE = "ubuntu/xenial64"
BOX_CPU_COUNT = 1
BOX_RAM_MB = "512"

### master node configuration
MASTER_IP = "172.81.81.2"
MASTER_HOSTNAME = "master01"

### replica nodes configuration
REPLICA_IP_PATTERN = "172.81.81."
REPLICA_COUNT = 2
REPLICA_PREFIX = "replica0"
START_REPLICATION_SCRIPT_FILE = "/usr/local/mongo-4.0.2/start-replication.js"

$script = <<-SCRIPT
echo $4$'\t'$5 >> /etc/hosts
counter=1
while [ $counter -le $1 ]
  do
    ip=$2$((counter+2))
    echo $ip$'\t'$3$counter >> /etc/hosts
    ((counter++))
  done
SCRIPT

Vagrant.require_version ">= 2.0.0"

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = BOX_CPU_COUNT
    vb.memory = BOX_RAM_MB
  end

  (1..REPLICA_COUNT).each do |i|
    config.vm.define "#{REPLICA_PREFIX}#{i}" do |node|
      node.vm.box = BOX_BASE
      node.vm.box_check_update = false
      node.vm.hostname = "#{REPLICA_PREFIX}#{i}"
      node.vm.network "private_network", ip: "#{REPLICA_IP_PATTERN}#{i+2}", netmask: "255.255.255.0"
      node.vm.provision "shell" do |s|
        s.inline = $script
        s.args = [REPLICA_COUNT, REPLICA_IP_PATTERN, REPLICA_PREFIX, MASTER_IP, MASTER_HOSTNAME]
      end
      node.vm.provision "shell", path: "scripts/install-mongo.sh"
    end
  end

  config.vm.define "#{MASTER_HOSTNAME}" do |node|
    node.vm.box = BOX_BASE
    node.vm.box_check_update = false
    node.vm.hostname = "#{MASTER_HOSTNAME}"
    node.vm.network "private_network", ip: MASTER_IP, netmask: "255.255.255.0"
    node.vm.provision "shell" do |s|
      s.inline = $script
      s.args = [REPLICA_COUNT, REPLICA_IP_PATTERN, REPLICA_PREFIX, MASTER_IP, MASTER_HOSTNAME]
    end
    node.vm.provision "shell", path: "scripts/install-mongo.sh"
    node.vm.provision "shell" do |s|
      s.path = "scripts/create-replication-script.sh"
      s.args = [MASTER_HOSTNAME, REPLICA_COUNT, REPLICA_PREFIX, START_REPLICATION_SCRIPT_FILE]
    end 
    node.vm.provision "shell" do |s|
      s.path = "scripts/start-replication.sh"
      s.args = [MASTER_HOSTNAME, START_REPLICATION_SCRIPT_FILE]
    end
  end
end