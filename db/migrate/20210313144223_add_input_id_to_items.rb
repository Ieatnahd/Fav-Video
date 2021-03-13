class AddInputIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :input_id, :string
  end
end
