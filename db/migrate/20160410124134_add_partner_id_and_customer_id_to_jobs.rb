class AddPartnerIdAndCustomerIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :partner_id, :integer
    add_column :jobs, :customer_id, :integer
  end
end
