# frozen_string_literal: true

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  test 'basic functionality' do
    plan = Plan.new(name: 'First plan')
    feature = plan.pay_features.new(identifier: 'my_feature', description: 'My feature', amount: 2)
    plan.save!

    assert_equal 1, plan.pay_features.count
    assert_equal 'my_feature', feature.identifier
    assert plan.has_feature?(:my_feature)
    assert_equal 2, plan.amount_for(:my_feature)
    assert_equal [{ identifier: 'my_feature', description: 'My feature', amount: 2 }], plan.display_features
  end

  test 'display features shows features from the previous plan' do
    first_plan = Plan.new(name: 'First plan')
    first_plan.pay_features.new(identifier: 'users', description: '2 users', amount: 2)
    first_plan.save!

    second_plan = Plan.new(name: 'Second plan', previous_plan: first_plan)
    second_plan.pay_features.new(identifier: 'projects', amount: 2)
    second_plan.save!

    assert_equal [{ identifier: 'users', description: '2 users' }, { identifier: 'projects', description: nil, amount: 2, new_feature: true }], second_plan.display_features
  end

  test 'display features shows feature as new if it exists in the previous plan and the current plan' do
    first_plan = Plan.new(name: 'First plan')
    first_plan.pay_features.new(identifier: 'users', description: '2 users', amount: 2)
    first_plan.save!

    second_plan = Plan.new(name: 'Second plan', previous_plan: first_plan)
    second_plan.pay_features.new(identifier: 'users', description: '3 users', amount: 3)
    second_plan.save!

    assert_equal [{ identifier: 'users', description: '3 users', amount: 3, new_feature: true }], second_plan.display_features
  end

  test "feature that doesn't exist on previous plan is marked as new_feature" do
    first_plan = Plan.new(name: 'First plan')
    first_plan.pay_features.new(identifier: 'users', description: '2 users', amount: 2)
    first_plan.save!

    second_plan = Plan.new(name: 'Second plan', previous_plan: first_plan)
    second_plan.pay_features.new(identifier: 'something')
    second_plan.save!

    assert_equal [{ identifier: 'users', description: '2 users' }, { identifier: 'something', description: nil, amount: nil, new_feature: true }], second_plan.display_features
  end

  test 'amount_for returns biggest number if no amount is set' do
    plan = Plan.new(name: 'First plan')
    plan.pay_features.new(identifier: 'api_access')
    plan.save!

    assert_equal PayFeatures::Plan::BIGGEST_AMOUNT, plan.amount_for(:api_access)
  end

  test 'amount_for returns smallest number if no feature exists' do
    plan = Plan.new(name: 'First plan')
    plan.save!

    assert_equal PayFeatures::Plan::SMALLEST_AMOUNT, plan.amount_for(:api_access)
  end

  test 'feature can be accessed all the way down through previous plans' do
    first_plan = Plan.new(name: 'First plan')
    first_plan.pay_features.new(identifier: 'users', description: '2 users', amount: 2)
    first_plan.save!

    second_plan = Plan.new(name: 'Second plan', previous_plan: first_plan)
    second_plan.pay_features.new(identifier: 'something')
    second_plan.save!
    assert second_plan.has_feature?(:users)

    third_plan = Plan.new(name: 'Third plan', previous_plan: second_plan)
    third_plan.save!

    assert third_plan.has_feature?(:users)
    assert_equal 2, third_plan.amount_for(:users)
  end
end
