# frozen_string_literal: true

class CreatePayFeaturesPlanFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :pay_features_plan_features do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :pay_feature, null: false, foreign_key: { to_table: :pay_features_pay_features }

      t.timestamps
    end
  end
end
