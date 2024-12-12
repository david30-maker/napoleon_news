class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description, limit: 500
      t.datetime :published_at
      t.datetime :approved_at
      t.integer :status

      t.references :approved_by, foreign_key: {to_table: 'users'}
      t.references :author, null: false, foreign_key: {to_table: 'users'}

      t.timestamps
    end
  end
end
