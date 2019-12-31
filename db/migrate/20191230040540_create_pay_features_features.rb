class CreatePayFeaturesFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :pay_features_pay_features do |t|
      t.string :description
      t.string :identifier
      t.integer :amount
      t.integer :order
      t.boolean :hidden
      t.boolean :enabled

      t.timestamps
    end
  end
end
