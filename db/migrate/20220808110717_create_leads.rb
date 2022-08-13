class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :employee_id
      t.integer :item_type
      t.text :heading
      t.text :description
      t.integer :quantity
      t.text :paper_type
      t.text :colour
      t.text :size
      t.string :s_no
      t.text :payment_details
      t.text :slip_no
      t.float :price
      t.integer :status

      t.timestamps
    end
  end
end
