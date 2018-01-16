class AddStatusProducts < ActiveRecord::Migration[5.0]
  def change
    change_table :products do |t|
      t.boolean :done
    end
  end
end
