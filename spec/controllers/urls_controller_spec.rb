require 'spec_helper'

describe UrlsController do
  describe "GET #new" do
    it "creates a blank Url instance" do
      get :new
      assigns(:url).class.should eq(Url)
    end
    
    it "does not change the Url count" do
      expect {
        get :new
      }.to change(Url, :count).by(0)
    end
  end
  
  describe "POST #create" do
    before(:each) do
      @test_url = FactoryGirl.build(:url)
      @test_url.save(validate: false)
    end
    
    # Since the app only updates existing stubs, creating a link should not change the number of rows in the database 
    it "does not change the Url count" do
      expect {
        post :create, :url => {:destination => "http://www.timrosenblatt.com" } 
      }.to change(Url, :count).by(0)
    end
    
    it "does update the stub's destination" do
      post :create, :url => {:destination => "http://www.timrosenblatt.com" }
      url = Url.find_by_stub(@test_url.stub).destination.should eq("http://www.timrosenblatt.com")
    end
    
    it "redirects to the preview"
  end
  
  describe "GET #show" do
    before(:each) do
      FactoryGirl.create(:url, stub: '123', destination: 'http://www.timrosenblatt.com/')
    end
    
    context "as a redirect" do
      it "should redirect" do
        get :show, stub: 123
        response.should redirect_to "http://www.timrosenblatt.com/"
      end
    end
    
    context "as a preview" do
      it "does not redirect" do
        get :show, stub: 123, preview: true
        response.should_not be_redirect
      end
    end
  end
end