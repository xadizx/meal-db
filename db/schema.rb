# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_24_202209) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer "external_id"
    t.string "name"
    t.string "thumbnail_image_url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favourite_meals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_favourite_meals_on_meal_id"
    t.index ["user_id"], name: "index_favourite_meals_on_user_id"
  end

  create_table "meal_ingredients", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.string "name"
    t.string "measurement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_meal_ingredients_on_meal_id"
  end

  create_table "meal_reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meal_id", null: false
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.index ["meal_id"], name: "index_meal_reviews_on_meal_id"
    t.index ["user_id"], name: "index_meal_reviews_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "external_id"
    t.string "name"
    t.string "thumbnail_image_url"
    t.string "tags"
    t.text "instructions"
    t.string "area"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_meals_on_category_id"
  end

  create_table "swipes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meal_id", null: false
    t.integer "preference", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_swipes_on_meal_id"
    t.index ["user_id", "meal_id"], name: "index_swipes_on_user_id_and_meal_id", unique: true
    t.index ["user_id"], name: "index_swipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favourite_meals", "meals"
  add_foreign_key "favourite_meals", "users"
  add_foreign_key "meal_ingredients", "meals"
  add_foreign_key "meal_reviews", "meals"
  add_foreign_key "meal_reviews", "users"
  add_foreign_key "meals", "categories"
  add_foreign_key "swipes", "meals"
  add_foreign_key "swipes", "users"
end
