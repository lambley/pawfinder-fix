class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :restaurant_type
      t.string :park_feature
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
