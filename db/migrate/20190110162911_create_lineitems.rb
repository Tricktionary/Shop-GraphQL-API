class CreateLineitems < ActiveRecord::Migration[5.2]
  def change
    create_table :lineitems do |t|
      t.integer :quantity
      t.belongs_to :product, foreign_key: true
      t.belongs_to :cart, foreign_key: true

      t.timestamps
    end
  end
end
