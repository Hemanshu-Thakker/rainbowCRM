class AddCreatedByToLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads, :created_by, :integer
  end
end
