require 'spec_helper'

describe Url do
  before :each do
    3.times do |t|
      FactoryGirl.build(:url).save(validate: false)
    end
  end
  
  # the purpose of this test is to emphasize that empty stubs are pre-created, and are not created on-the-fly
  it "can not be created as a typical model" do
    FactoryGirl.build(:url).should_not be_valid
  end
  
  # again, for emphasis that URLs are created from the rake task
  it "cannot be saved without a destination" do
    FactoryGirl.build(:url).should_not be_valid
  end
  
  it "will reject non-URL destinations" do
    FactoryGirl.build(:url, destination: "things that aren't valid. this.").should_not be_valid
  end
  
  it "can create arbitrary stubs that will not be in the general pool" do
    FactoryGirl.create(:url, destination: 'http://www.timrosenblatt.com').should be_valid
  end
  
  it "can create new redirections" do
    url = Url.create_stub_for('http://www.timrosenblatt.com')
    url.stub.should_not be_empty
    url.destination.should_not be_empty
    
    url_test = Url.find_by_stub(url.stub)
    url_test.destination.should eq(url.destination)
  end
  
  it "does not allow duplicate stubs" do
    FactoryGirl.create(:url, stub: 'abc123', destination: 'http://www.timrosenblatt.com').should be_valid
    FactoryGirl.build(:url, stub: 'abc123', destination: 'http://www.github.com').should_not be_valid
  end
  
end