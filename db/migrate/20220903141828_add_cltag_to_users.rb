class AddCltagToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cl_tag, :string
  end
end
