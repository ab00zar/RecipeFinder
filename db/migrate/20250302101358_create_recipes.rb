class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.decimal :ratings, precision: 5, scale: 2
      t.string :ingredients, array: true, default: []
      t.string :category
      t.string :author
      t.string :image
      t.tsvector :ingredients_vector

      t.timestamps
    end

    add_index :recipes, :ingredients_vector, using: :gin
    add_index :recipes, :ratings
  end
end
