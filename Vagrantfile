# -*- mode: ruby -*-
# vi: set ft=ruby :
RAM = 1024

Vagrant.configure("2") do |config|
  # Serveur virtuel de d�monstration



  config.vm.define "srv-database" do |machinebdd|

    machinebdd.vm.hostname = "srv-database"
    machinebdd.vm.box = "chavinje/fr-bull-64"
    machinebdd.vm.network :private_network, ip: "192.168.56.81"


    #Acces � la VM Web � distance
    machinebdd.vm.network "public_network", use_dhcp_assigned_default_route: true
    #machinebdd.vm.network "public_network", ip: "192.168.0.154"



    # Un repertoire partag� est un plus mais demande beaucoup plus
    # de travail - a voir � la fin
    machinebdd.vm.synced_folder "./data", "/vagrant_data", SharedFoldersEnableSymlinksCreate: false

    machinebdd.vm.provider :virtualbox do |vbdd|
      vbdd.customize ["modifyvm", :id, "--name", "srv-database"]
      vbdd.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      vbdd.customize ["modifyvm", :id, "--cpus", "1"]
      vbdd.customize ["modifyvm", :id, "--memory", RAM]
      vbdd.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      vbdd.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end

    #permet d'effectuer la connexion ssh de r�duire le niveau de securite en mode ssh et de
    #redescendre le cran du niveau de securite � cause de certains qui vont apparaitre
    machinebdd.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      sleep 3
      service ssh restart


    SHELL
    #
    machinebdd.vm.provision "shell", path: "scripts/install_sys.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/install_bdd.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/install_web.sh"
    #machine.vm.provision "shell", path: "scripts/install_myadmin.sh"



  end



  config.vm.define "srv-proxyhttps" do |machineh|
      machineh.vm.hostname = "srv-proxyhttps"
      machineh.vm.box = "chavinje/fr-bull-64"
      #machine.vm.network :private_network, ip: "19.16.56.15"

      #Acces � la VM Web � distance
      machine.vm.network "public_network", use_dhcp_assigned_default_route: true
      #machine.vm.network "public_network", ip: "192.168.0.155"

      # Un repertoire partag� est un plus mais demande beaucoup plus
      # de travail - a voir � la fin
      machineh.vm.synced_folder "./data", "/vagrant_data", SharedFoldersEnableSymlinksCreate: false

      machineh.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--name", "srv-proxyhttps"]
        v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
        v.customize ["modifyvm", :id, "--memory", RAM]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      end

      machineh.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
        sleep 3
        service ssh restart
      SHELL

      #
      #machine.vm.provision "shell", path: "scripts/install_sys.sh"
      #
    # machine.vm.provision "shell", path: "scripts/install_web.sh"
      #machine.vm.provision "shell", path: "scripts/install_myadmin.sh"
  end


  config.vm.define "srv-web" do |machine|
      machine.vm.hostname = "srv-web"
      machine.vm.box = "chavinje/fr-bull-64"
      machine.vm.network :private_network, ip: "192.168.56.80"

      #Acces � la VM Web � distance
      machine.vm.network "public_network", use_dhcp_assigned_default_route: true
      #machine.vm.network "public_network", ip: "192.168.0.155"

      # Un repertoire partag� est un plus mais demande beaucoup plus
      # de travail - a voir � la fin
      machine.vm.synced_folder "./data", "/vagrant_data", SharedFoldersEnableSymlinksCreate: false

      machine.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--name", "srv-web"]
        v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
        v.customize ["modifyvm", :id, "--memory", 2*RAM]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      end

      machine.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
        sleep 3
        service ssh restart
      SHELL

      #
      machine.vm.provision "shell", path: "scripts/install_sys.sh"
      #
      machine.vm.provision "shell", path: "scripts/install_web.sh"
      #machine.vm.provision "shell", path: "scripts/install_myadmin.sh"
  end




end
