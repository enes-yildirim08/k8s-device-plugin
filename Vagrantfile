Dir["./utilities/ruby-libs/*.rb"].each {|file| require file }

VAGRANTFILE_API_VERSION = "2"

ANSIBLE_IP = "172.8.88.158"

check_plugins

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "geerlingguy/ubuntu2004"
  config.vm.box_version = "1.0.4"

  config.ssh.insert_key = false
  config.vm.provider "virtualbox"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./", "/vagrant", privileged: true

  config.vm.define "ansible" do |box|
    box.vm.hostname = "ansible"
    box.vm.network :private_network, ip: ANSIBLE_IP

    box.vm.provision "shell", inline: "cat /vagrant/ssh/vagrant_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys", privileged: false

    box.vm.provider :virtualbox do |v|
      v.memory = "1024"
      v.cpus = "1"
      v.linked_clone = true
      v.auto_nat_dns_proxy = false
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    end

    # github_user = get_github_user

    # box.vm.provision "shell", inline: "echo -n #{github_user} > /vagrant/github-username"
    box.vm.provision "shell", inline: "echo 'cd /vagrant' >> /home/vagrant/.bashrc"

    box.vm.provision "shell", inline: <<-SHELL
      apt-get update -y && apt-get install -y python3-pip python3-venv jq
      pip3 -q install PyYAML==5.4.1 ansible==2.10.7 ansible-modules-hashivault==4.5.1 openshift==0.13.1
      curl -fsSL https://storage.googleapis.com/kubernetes-release/release/v1.27.7/bin/linux/amd64/kubectl -o /usr/bin/kubectl && chmod +x /usr/bin/kubectl
    SHELL

    box.vm.provision "shell", inline: "ansible-galaxy collection install kubernetes.core:==3.0.0", privileged: false
    box.vm.provision "shell", inline: "cd /vagrant && ./provision-local-tools.sh", privileged: false
  end
end
