class AddProfessionToCalculation < ActiveRecord::Migration
  def change
    add_column :calculations, :profession, :string
  end
end
