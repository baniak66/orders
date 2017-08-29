class Order < ApplicationRecord
  belongs_to :user
  has_many :meals
  validates :restaurant, :status, :user_id, presence: true, allow_blank: false
end
