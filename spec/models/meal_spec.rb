require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :order_id }
    it { is_expected.to validate_numericality_of :price }
  end

  describe 'database columns' do
    it { should have_db_column :name }
    it { should have_db_column :price }
    it { should have_db_column :user_id }
    it { should have_db_column :order_id }
  end

  describe 'associations' do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :user }
  end
end
