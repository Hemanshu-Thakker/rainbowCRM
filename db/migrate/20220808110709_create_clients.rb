class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.string :company_name
      t.string :gst_number
      t.text :note

      t.timestamps
    end
  end
end
