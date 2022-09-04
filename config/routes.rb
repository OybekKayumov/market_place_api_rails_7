Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     get 'tokens/create'
  #   end
  # end
  #Api definition
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :orders, only: %i[index show create]
      resources :users, only: %i[show create update destroy]
      resources :tokens, only: [:create]
      resources :products
    end
    
  end
end


# :v1
# By this point the API is now scoped via the URL. For example with the
# current configuration an end point for retrieving a product would be
# 23like: http://localhost:3000/v1/products/1 