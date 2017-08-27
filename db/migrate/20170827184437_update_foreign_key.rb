class UpdateForeignKey < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :meals, :orders
    add_foreign_key :meals, :orders, on_delete: :cascade
  end
end
