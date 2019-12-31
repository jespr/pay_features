module PayFeatures
  class PayFeature < ApplicationRecord
    self.table_name = "pay_features_pay_features"

    has_many :plan_features, class_name: "PayFeatures#PlanFeature"
    has_many :plans, through: :plan_features
  end
end
