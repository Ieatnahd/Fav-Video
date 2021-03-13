class AddUrlToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :url, :string
  end
end
