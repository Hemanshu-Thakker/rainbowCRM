class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :contact
      t.integer :employee_type
      
      t.timestamps
    end
  end
end
