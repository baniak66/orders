class Meal < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :price, :numericality => true
  validates :name, presence: true, allow_blank: false
end
