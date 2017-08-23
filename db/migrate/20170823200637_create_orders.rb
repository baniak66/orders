class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :restaurant, null: false
      t.string :status, default: "active"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
