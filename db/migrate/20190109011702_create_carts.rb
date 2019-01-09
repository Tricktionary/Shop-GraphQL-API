class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.float :total_value
      t.boolean :completed

      t.timestamps
    end
  end
end
