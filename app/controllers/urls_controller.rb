class UrlsController < ApplicationController
  
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

  def create
    @url = Url.create_stub_for(params[:url][:destination])
    
    if @url.errors.empty?
      redirect_to action: "show", stub: @url.stub, preview: true
    else
      render action: "new"
    end
  end

end
