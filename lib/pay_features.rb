# frozen_string_literal: true

require 'pay_features/engine'
require 'pay_features/plan'

module PayFeatures
  mattr_accessor :plan_class
  mattr_accessor :plan_table

  @@plan_class = 'Plan'
  @@plan_table = 'plans'

  def self.setup
    yield self
  end

  def self.plan_model
    if Rails.application.config.cache_classes
      @@plan_model ||= plan_class.constantize
    else
      plan_class.constantize
    end
  end
end
