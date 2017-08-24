class Order < ApplicationRecord
  belongs_to :user
  validates :restaurant, presence: true, allow_blank: false
end
