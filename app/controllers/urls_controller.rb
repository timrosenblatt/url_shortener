class UrlsController < ApplicationController
  
  # TODO handle the case where an invalid stub is passed in
  def show
    @url = Url.find_by_stub(params[:stub])

    unless params[:preview]
      redirect_to @url.destination
      return
    end
    
    render action: "show"
  end

  def new
    @url = Url.new
  end
  
  # TODO raise and handle an exception in the case that there are no available stubs
  def create
    @url = Url.create_stub_for(params[:url][:destination])
    
    if @url.errors.empty?
      redirect_to action: "show", stub: @url.stub, preview: true
    else
      render action: "new"
    end
  end

end
