class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes 
  belongs_to :user
  has_many :products
end
