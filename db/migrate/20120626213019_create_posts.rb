class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :type
      t.references :site

      t.timestamps
    end
  end
end
