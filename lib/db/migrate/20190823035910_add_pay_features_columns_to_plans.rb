class AddPayFeaturesColumnsToPlans < ActiveRecord::Migration[5.2]
    def change
      add_column :plans, :previous_plan_id, :integer
      add_index :plans, :previous_plan_id
  
      add_column :plans, :next_plan_id, :integer
      add_index :plans, :next_plan_id
    end
  end