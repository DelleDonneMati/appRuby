class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :unicode, :unique => true , :null => false
      t.string :descrip, :null => false
      t.string :detail, :null => false
      t.string :price, :null => false

      t.timestamps
    end
  end
end
