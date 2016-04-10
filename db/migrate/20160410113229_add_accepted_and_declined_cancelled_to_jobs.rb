class AddAcceptedAndDeclinedCancelledToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :accepted, :boolean
    add_column :jobs, :declined, :boolean
    add_column :jobs, :cancelled, :boolean
    add_column :jobs, :responded_to, :boolean
  end
end
