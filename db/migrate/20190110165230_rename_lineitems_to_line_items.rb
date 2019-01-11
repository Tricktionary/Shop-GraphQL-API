class RenameLineitemsToLineItems < ActiveRecord::Migration[5.2]
  def change
    rename_table :lineitems, :line_items
  end
end
