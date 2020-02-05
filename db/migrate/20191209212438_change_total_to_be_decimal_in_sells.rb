class ChangeTotalToBeDecimalInSells < ActiveRecord::Migration[6.0]
  def change
    change_column(:sells, :total, :decimal)
  end
end
