class StubGeneratorSupport
  LOWERCASE_LETTERS = ('a'..'z').to_a
  NUMBERS = ('0'..'9').to_a
  STUB_CHARACTERS = LOWERCASE_LETTERS + NUMBERS
end


namespace :stubs do
  
  # This must be run before the app will work
  desc "Provision a set of stubs for redirection"
  task :generate => :environment do
    
    c = StubGeneratorSupport::STUB_CHARACTERS
    
    # As the stub namespace expands, be mindful of memory. Generating a large number of stubs
    # at a single time will start to consume an exponential amount of memory. 
    # 
    # When physical memory runs out, it will start using virtual memory. The virtual memory will 
    # start paging to/from disk and midway through the cycle, the whole thing will start running **VERY** slow
    #
    # You have been warned :)
    stubs = []
    
    c.each do |c1|
      c.each do |c2|
          stubs << c1 + c2
      end
    end
      
    # TODO this takes about 7 minutes to run. These queries would run A LOT faster if they were buffered
    i = 0 # just as a status, stubs of size 3 should take about 7 minutes to insert
    stubs.each do |stub|
      url = Url.new(stub: stub)
      url.save(validate: false)
      
      i += 1
      if(i%10==0)
        puts "#{i} at #{Time.now}" # if you start seeing this puts slowing down, you are hitting the virtual memory wall
      end
    end
  end

  desc "Manually create a new stub, or set an existing stub"
  task :assign do
    
  end
  
end
