# frozen_string_literal: true

class AddFieldsToPlan < ActiveRecord::Migration[6.0]
  def change
    add_column PayFeatures.plan_table, :previous_plan_id, :integer
    add_index PayFeatures.plan_table, :previous_plan_id
  end
end
