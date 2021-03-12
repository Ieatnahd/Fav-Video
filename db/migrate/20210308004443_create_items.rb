class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :url
      t.string :title
      t.string :channel
      t.string :content
      t.string :thumbnail_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
