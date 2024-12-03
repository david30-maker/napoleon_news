class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.datetime :published_at
      t.datetime :approved_at
      t.integer :approved_by
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
