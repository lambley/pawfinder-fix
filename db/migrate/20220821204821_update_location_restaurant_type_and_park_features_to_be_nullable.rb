class UpdateLocationRestaurantTypeAndParkFeaturesToBeNullable < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :restaurant_type, :string, null: true, default: nil
    change_column :activities, :park_feature, :string, null: true, default: nil
  end
end
