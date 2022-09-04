class Order < ApplicationRecord
  belongs_to :user
  validates :total, numericality: { greater_tahn_or_equal_to: 0 }
  validates :total, presence: true
end
