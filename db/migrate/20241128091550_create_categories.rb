class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :created_by, foreign_key: {to_table: 'users'}, null: true

      t.timestamps
    end
  end
end
