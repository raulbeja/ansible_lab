nodes = [
    { :hostname => 'labnode',
      :ip => '192.168.56.20',
      :box => 'bento/ubuntu-22.04',
      :ram => 2048,
      :cpus => 2 },
    { :hostname => 'master',
      :ip => '192.168.56.10',
      :box => 'bento/ubuntu-22.04',
      :ram => 2048,
      :cpus => 2 } 
  ]

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  config.vm.box_check_update = false

  if Vagrant.has_plugin?("vagrant-vbguest")
     config.vbguest.auto_update = false
  end
  
  nodes.each do |node|        
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname]
      nodeconfig.vm.network "private_network", ip: node[:ip]
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.memory = node[:ram] ? node[:ram] : 512;
        vb.cpus = node[:cpus] ? node[:cpus] : 1;
      end

      nodeconfig.vm.provision "shell", path: "bootstrap.sh"

      if node[:hostname]=="master"
        nodeconfig.vm.provision :file, source: "ansible_labs", destination: "/home/vagrant/ansible_labs"
        nodeconfig.vm.provision "shell", path: "check.sh", privileged:false
        nodeconfig.vm.provision "ansible_local" do |ansible|
          ansible.limit = "all,localhost"
          ansible.groups = {
              "labnodes" => ["labnode"]
              }  
          ansible.playbook = "ansible_labs/demo.yml"  
        end
      end
    end
  end  
end
