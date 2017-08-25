class Order < ApplicationRecord
  belongs_to :user
  has_many :meals
  validates :restaurant, presence: true, allow_blank: false
end
