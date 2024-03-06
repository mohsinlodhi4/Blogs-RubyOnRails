Rails.application.routes.draw do
  
  namespace 'api' do

    resources :posts

    get "/replies-post/:post_id", to: 'replies#index'
    post "/save-reply/:post_id", to: 'replies#create'
    get "/reply/:id", to: 'replies#show'
    put "/reply/:id", to: 'replies#update'
    delete "/reply/:id", to: 'replies#destroy'
  
  end
  
end
