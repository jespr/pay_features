# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_30_182348) do

  create_table "pay_features_pay_features", force: :cascade do |t|
    t.string "description"
    t.string "identifier"
    t.integer "amount"
    t.integer "order"
    t.boolean "hidden"
    t.boolean "enabled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pay_features_plan_features", force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "pay_feature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pay_feature_id"], name: "index_pay_features_plan_features_on_pay_feature_id"
    t.index ["plan_id"], name: "index_pay_features_plan_features_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "pay_features_plan_features", "pay_features_pay_features", column: "pay_feature_id"
  add_foreign_key "pay_features_plan_features", "plans"
end
