class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :unicode
      t.string :descrip
      t.string :detail
      t.string :price
      t.string :name

      t.timestamps
    end
  end
end
