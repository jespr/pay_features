# frozen_string_literal: true

require 'test_helper'

class PayFeatures::Test < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, PayFeatures
  end

  test 'default plan class is Plan' do
    assert_equal 'Plan', PayFeatures.plan_class
  end

  test 'default plan table is plans' do
    assert_equal 'plans', PayFeatures.plan_table
  end
end
