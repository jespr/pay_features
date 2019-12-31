require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  test "the truth" do
    plan = Plan.new(name: "First plan")
    # raise plan.plan_features.new.inspect
    # feature = plan.features.new(identifier: "my_feature", amount: 2)
    # plan.save!

    # assert_equal 1, plan.features.count
  end
end
 