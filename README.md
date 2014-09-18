###Steps used in the "Using Puppet to Stand Up Centralized Logging and Metrics" workshop at PuppetConf 2014

####Part 1 - Getting centralized logging

1. Get this repo - `git clone charlesdunbar`
2. Initialize everything with `vagrant up`
3. Install the modules being used:
 
		vagrant ssh master
 		sudo -i
 		puppet module install saz-rsyslog
		cp /vagrant/manifests/site-rsyslog.pp /etc/puppet/manifests/site.pp
		exit
		exit
		
4. Run puppet on all agents - `./run-puppet.sh`

####Part 2 - Getting ELK configured

1. Add extra modules to puppet master and install templates

		vagrant ssh master
		sudo -i
		puppet module install elasticsearch-logstash
		puppet module install elasticsearch-elasticsearch
		puppet module install thejandroman-kibana3
		cp /vagrant/manifests/site-elk.pp /etc/puppet/manifests/site.pp
		cp /vagrant/modules/logstash/templates/* /etc/puppet/modules/logstash/templates/
		exit
		exit
		
2. Run puppet on rsyslog and elk - 


		vagrant ssh elk -c "sudo puppet agent -t"; vagrant ssh rsyslog -c "sudo puppet agent -t"
		
3. Access elasticsearch at either -
		
		http://localhost:9200/_plugin/head/
		http://localhost:9200/_plugin/kopf/
		
4. Access kibana at -

		http://localhost:8080/



####Part 3 - Shipping web logs with logstashforwarder

#####Note: You'll need apache/nginx access logs.  Store them in this repo directory as "access.log".
	
1. Install the module (using git as it's not on the forge)
		
		vagrant ssh master
		sudo -i
		cd /etc/puppet/modules
		puppet module install puppetlabs-apt
		git clone https://github.com/elasticsearch/puppet-logstashforwarder.git logstashforwarder
		cp /vagrant/logstash-forwarder /etc/puppet/modules/logstashforwarder/templates/logstash-forwarder.erb
		cp /vagrant/manifests/site-lsf.pp /etc/puppet/manifests/site.pp
		exit
		exit
	
2. Run puppet on client and elk (Run three times on client to handle dependency errors and a broken init script in the package) - 

		vagrant ssh elk -c "sudo puppet agent -t"; vagrant ssh client -c "sudo puppet agent -t"; vagrant ssh client -c "sudo puppet agent -t"; vagrant ssh client -c "sudo puppet agent -t"
		
3. Populate the log that logstash-forwarder is watching -

		vagrant ssh client -c "sudo cp /vagrant/access.log /tmp/access.log"


3. Access kibana at [http://localhost:8080/index.html#/dashboard/file/logstash.json](http://localhost:8080/index.html#/dashboard/file/logstash.json) to see all your logs
		

