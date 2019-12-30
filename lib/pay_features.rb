require "pay_features/engine"

module PayFeatures
  mattr_accessor :plan_class

  @@plan_class = 'Plan'

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
