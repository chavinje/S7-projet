# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Configuration du server web
  config.vm.define "server-web" do |web|
    web.vm.hostname = "server-web"
    web.vm.box = "chavinje/fr-bull-64"
    web.vm.network :private_network, ip: "192.168.56.10"
    web.vm.network "forwarded_port", guest:80, host:8080,
      auto_correct: true

    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "server-web"]
      v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end

    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      sleep 3
      service ssh restart
    SHELL
    #web.vm.provision "file", source: "C:/Users/aguib/App.js", destination: "/tmp/web/App.js"
    web.vm.provision "shell", path: "scripts/installation_Systeme_web.sh"
    web.vm.provision "shell", path: "scripts/install_web.sh"
    web.vm.provision "shell", path: "scripts/install_moodle.sh"
    web.vm.provision "shell", path: "scripts/install_myadmin.sh"
  end

  # Configuration du serveur pour les base de donnée
  config.vm.define "database-server" do |database|
    database.vm.hostname = "database-server"
    database.vm.box = "chavinje/fr-bull-64"
    database.vm.network :private_network, ip: "192.168.56.12"
    database.vm.network "forwarded_port", guest:3306, host:3306,
      auto_correct: true

    database.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "database-server"]
      v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end

    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      sleep 3
      service ssh restart
    SHELL

    database.vm.provision "shell", path: "scripts/installation_Systeme_base_donnee.sh"
    database.vm.provision "shell", path: "scripts/install_bdd.sh"
    database.vm.provision "shell", path: "scripts/MysqlDump.sh"
  end

  # Configuration d'une 3e VM avec SSH distant et https
  config.vm.define "ssh-https" do |ssh|
    ssh.vm.hostname = "ssh-https"
    ssh.vm.box = "chavinje/fr-bull-64"
    ssh.vm.network :private_network, ip: "192.168.56.14"
    ssh.vm.network "public_network", use_dhcp_assigned_default_route: true

    ssh.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "ssh-https"]
      v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end

    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      sleep 3
      service ssh restart
    SHELL
    ssh.vm.provision "shell", path: "scripts/reverse_proxy.sh"
    #ssh.vm.provision "shell", path: "scripts/proxy.sh"
  end
end

    # Un repertoire partagé est un plus mais demande beaucoup plus
    # de travail - a voir à la fin
    #machine.vm.synced_folder "./data", "/vagrant_data", SharedFoldersEnableSymlinksCreate: false
    #machine2.vm.provision "shell", path: "scripts/install_moodle.sh"
    #machine2.vm.provision "shell", path: "scripts/install_myadmin.sh"
