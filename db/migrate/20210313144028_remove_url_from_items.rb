class RemoveUrlFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :url, :string
  end
end
