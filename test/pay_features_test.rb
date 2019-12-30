require 'test_helper'

class PayFeatures::Test < ActiveSupport::TestCase
  test 'default plan class is Plan' do
    assert_equal 'Plan', PayFeatures.plan_class
  end
end
