class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.belongs_to :store, index: true
      t.belongs_to :book, index: true
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
