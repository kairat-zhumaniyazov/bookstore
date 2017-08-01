class AddPubliserIdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :publisher, index: true
  end
end
