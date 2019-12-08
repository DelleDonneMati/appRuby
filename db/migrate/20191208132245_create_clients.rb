class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :cuit
      t.string :name
      t.references :type, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
