class Url < ActiveRecord::Base
  
  # This is *not* a bulletproof validation. TODO upgrade to a real URL parse, and consider other prototcols
  validates :destination, :format => { :with => /^(http|https):\/\//, :message => "must be an HTTP or HTTPS link" }
  validates_presence_of :stub
  validates_uniqueness_of :stub

  def self.create_stub_for(url)
    Url.transaction do  
      @url = Url.lock.find_by_destination(nil, :limit => 1)
      @url.destination = url
      @url.save
      @url
    end
  end
  
end
