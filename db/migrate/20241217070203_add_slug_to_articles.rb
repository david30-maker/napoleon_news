class AddSlugToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :Slug, :string
    add_index :articles, :Slug, unique: true
  end
end
