class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.integer :age
      t.integer :working_years
      t.integer :working_years_total
      t.integer :gross_salary
      t.text :education_level
      t.text :email_address

      t.timestamps null: false
    end
  end
end
