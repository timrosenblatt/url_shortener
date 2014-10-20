UrlShortener::Application.routes.draw do
  post '/' => 'urls#create'
  root :to => 'urls#new'
  get '/:stub/preview' => 'urls#show', :defaults => { :preview => true }
  get '/:stub' => 'urls#show'
end
