class CreatePayFeaturesTables < ActiveRecord::Migration[5.2]
    def change
      create_table :pay_features do |t|
        t.text :description
        t.string :identifier
        t.integer :amount
        t.integer :order
        t.boolean :hidden, default: false
  
        t.timestamps
      end

      create_table :plan_features do |t|
        t.belongs_to :plan, foreign_key: true
        t.belongs_to :feature, foreign_key: true
  
        t.timestamps
      end
    end
  end
  