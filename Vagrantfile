# -*- mode: ruby -*-
# vi: set ft=ruby :
RAM = 1024

Vagrant.configure("2") do |config|
  # Serveur virtuel de d�monstration

  config.vm.define "srv-web", primary: true do |machine|
    machine.vm.hostname = "srv-web"
    machine.vm.box = "chavinje/fr-bull-64"
    machine.vm.network :private_network, ip: "192.168.56.80"

    #Acces � la VM Web � distance
    #machine.vm.network "public_network", use_dhcp_assigned_default_route: true

    #peut creer un conflit si cette adresse ip est déjà assigné à une personne
    #machine.vm.network "public_network", ip: "*.*.*.*"


    # Un repertoire partag� est un plus mais demande beaucoup plus
    # de travail - a voir � la fin
    machine.vm.synced_folder "./data", "/vagrant_data", SharedFoldersEnableSymlinksCreate: false

    machine.vm.provider :virtualbox do |v2|
      v2.customize ["modifyvm", :id, "--name", "srv-web"]
      v2.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v2.customize ["modifyvm", :id, "--cpus", "1"]
      v2.customize ["modifyvm", :id, "--memory", 3*RAM]
      v2.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v2.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
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
    #
    machine.vm.provision "shell", path: "scripts/install_myadmin.sh"
    #
    machine.vm.provision "shell", path: "scripts/SITEWEB/GitClone.sh"
    #
    machine.vm.provision "shell", path: "scripts/SITEWEB/Configconf.sh"
    #
    machine.vm.provision "shell", path: "scripts/utilisateur.sh"




  end


  config.vm.define "srv-database" do |machinebdd|

    machinebdd.vm.hostname = "srv-database"
    machinebdd.vm.box = "chavinje/fr-bull-64"
    machinebdd.vm.network :private_network, ip: "192.168.56.81"
    machinebdd.vm.network "forwarded_port", guest: 3306, host: 8069
    # Un repertoire partagée est un plus mais demande beaucoup plus
    # de travail - a voir à la fin
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

      echo "====> SCRIPT Table CRON"
      sudo bash /vagrant/scripts/Sauvegarde.sh



    SHELL
    #
    machinebdd.vm.provision "shell", path: "scripts/install_sys.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/install_web.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/install_bdd.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/install_myadmin.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/recup_sql.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/TablesCreation.sh"
    #
    machinebdd.vm.provision "shell", path: "scripts/utilisateur.sh"
    #
    #machinebdd.vm.provision "shell", path: "scripts/Sauvegarde.sh"



  end

  #N'oublie de pas de decommenter la ligne pour que le dhcp attribue une adresse publique à ma VM
  #Adresse privée commentée
  config.vm.define "srv-proxyhttps" do |machineh|
      machineh.vm.hostname = "srv-proxyhttps"
      machineh.vm.box = "chavinje/fr-bull-64"
      machineh.vm.network :private_network, ip: "192.168.56.82"

      #Acces � la VM Web � distance
      #machineh.vm.network "public_network", use_dhcp_assigned_default_route: true

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
      machineh.vm.provision "shell", path: "scripts/install_sys.sh"
      #
      machineh.vm.provision "shell", path: "scripts/install_web.sh"
      #
      machineh.vm.provision "shell", path: "scripts/install_myadmin.sh"
      #
      machineh.vm.provision "shell", path: "scripts/configuration_proxy.sh"
      #
      machineh.vm.provision "shell", path: "scripts/distributioncle.sh"
      #
      achineh.vm.provision "shell", path: "scripts/certificats/creations_keys.sh"
      #
      machineh.vm.provision "shell", path: "scripts/certificats/ssl_configuration.sh"
      #
  end






end
