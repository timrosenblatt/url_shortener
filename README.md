Installed MySQL on the Vagrant box with root/12345

## Deploying

	rake db:create
	rake db:migrate
	

Look in stubs.rake to generate stubs. For performance, scalability, and management reasons, I am pre-generating all stubs. This allows me to:
* quickly generate a new short URL (with a 'select where destination_url is null' approach)
* avoid stub collisions that could occur with dynamically provisioning them (and prevent ever losing the algorithm)
* randomly assign stubs, so that there is no sequential logic that could be exploited for security reasons
* I can pre-assign my own stubs manually, and I can easily query the remaining empty stubs (something that would be more complicated to model with an algorithmic approach)
* scale

TODO: handle concurrency. Testing and assignment of stubs should always be atomic
TODO: for scale, set this whole thing up using an ARCHIVE table. Much faster reads.
TODO: finish `rake stubs:assign` 
