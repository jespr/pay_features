# frozen_string_literal: true

module PayFeatures
  class PlanFeature < ApplicationRecord
    self.table_name = 'pay_features_plan_features'

    belongs_to :plan
    belongs_to :pay_feature, class_name: 'PayFeatures::PayFeature'
  end
end
