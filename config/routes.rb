Rails.application.routes.draw do
  #Api definition
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
    end
    
  end
end


# :v1
# By this point the API is now scoped via the URL. For example with the
# current configuration an end point for retrieving a product would be
# 23like: http://localhost:3000/v1/products/1 