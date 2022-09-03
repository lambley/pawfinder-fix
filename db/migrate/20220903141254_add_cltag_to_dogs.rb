class AddCltagToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :cl_tag, :string
  end
end
