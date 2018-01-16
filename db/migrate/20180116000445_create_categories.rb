class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :parent_category

      t.timestamps
    end

    create_table :categories_products do |t|
      t.integer :category_id
      t.integer :product_id

      t.timestamps
    end
  end
end
