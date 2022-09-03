class AddCltagToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :cl_tag, :string
  end
end
