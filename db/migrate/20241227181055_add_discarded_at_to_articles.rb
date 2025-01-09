class AddDiscardedAtToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :discarded_at, :datetime
    add_index :articles, :discarded_at
  end
end
