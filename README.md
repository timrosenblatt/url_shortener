## Development
The development environment is based of a totally empty box

	vagrant box add lucid64 http://files.vagrantup.com/lucid64.box
	vagrant init lucid64
	vagrant up
	
Once you get in, don't forget
	apt-get update
	apt-get upgrade

Then install RVM, and do a bundle install, along with all the dependencies that are req'd 

Currently using MySQL on the Vagrant box with root/12345

Vagrant will bind /srv/url_shortener in the VM to the Rails root

## Deploying

	rake db:create
	rake db:migrate
	rake stubs:generate
	

Look in stubs.rake to generate stubs. For performance, scalability, and management reasons, I am pre-generating all stubs. This allows me to:
* quickly generate a new short URL (with a 'select where destination_url is null' approach)
* avoid stub collisions that could occur with dynamically provisioning them (and prevent ever losing the algorithm)
* randomly assign stubs, so that there is no sequential logic that could be exploited for security reasons
* I can pre-assign my own stubs manually, and I can easily query the remaining empty stubs (something that would be more complicated to model with an algorithmic approach)
* scale

TODOs!
* handle concurrency. Testing and assignment of stubs should always be atomic
* for scale, set this whole thing up using an ARCHIVE table. Much faster reads.
* finish `rake stubs:assign` 
