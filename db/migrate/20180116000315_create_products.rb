class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :number
      t.float :price
      t.string :description
      t.string :brand
      t.string :dimensions
      t.string :images, array: true
      t.string :thumbnail

      t.timestamps
    end
  end
end
