require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :restaurant }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :user_id }
  end

  describe 'database columns' do
    it { should have_db_column :restaurant }
    it { should have_db_column :status }
    it { should have_db_column :user_id }
  end

  describe 'associations' do
    it { is_expected.to have_many :meals }
    it { is_expected.to belong_to :user }
  end
end
