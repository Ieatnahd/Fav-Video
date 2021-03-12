class RenameUrlColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :url, :video_id
  end
end
