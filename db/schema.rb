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

ActiveRecord::Schema[7.0].define(version: 2023_05_18_170051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "add_default_tax_to_products", force: :cascade do |t|
    t.integer "default_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country", default: "Argentina", null: false
    t.string "state", default: "Buenos Aires", null: false
    t.string "city", default: "Buenos Aires", null: false
    t.string "street_name", null: false
    t.string "street_number", null: false
    t.string "post_code", null: false
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.boolean "available", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_id", "addressable_type", "available"], name: "index_addresses_on_addressable_and_available", unique: true, where: "available"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "products_count", default: 0, null: false
    t.bigint "category_id"
    t.bigint "company_id", null: false
    t.boolean "available", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["company_id"], name: "index_categories_on_company_id"
    t.index ["name", "company_id", "available"], name: "index_categories_on_name_and_company_id_and_available", unique: true, where: "available"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "iva_status", default: 0, null: false
    t.string "id_number"
    t.string "business_name"
    t.string "phone_number"
    t.string "email"
    t.index ["available", "email"], name: "index_companies_on_available_and_email", unique: true, where: "available"
    t.index ["available", "id_number"], name: "index_companies_on_available_and_id_number", unique: true, where: "available"
    t.index ["name", "available"], name: "index_companies_on_name_and_available", unique: true, where: "available"
  end

  create_table "images", force: :cascade do |t|
    t.string "url", null: false
    t.bigint "company_id", null: false
    t.boolean "available", default: true, null: false
    t.bigint "imageable_id", null: false
    t.string "imageable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_images_on_company_id"
    t.index ["imageable_id", "imageable_type", "available"], name: "index_images_on_imageable_id_and_imageable_type_and_available", unique: true, where: "available"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "description", limit: 10000, null: false
    t.bigint "category_id"
    t.bigint "company_id", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "stock", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "unit", default: 0, null: false
    t.boolean "available", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", default: "", null: false
    t.string "model", default: "", null: false
    t.decimal "default_tax", precision: 5, scale: 2, default: "21.0"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["name", "company_id", "available"], name: "index_products_on_name_and_company_id_and_available", unique: true, where: "available"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "percentage", default: 0, null: false
    t.bigint "taxeable_id", null: false
    t.string "taxeable_type", null: false
    t.boolean "available", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_taxes_on_name", unique: true
    t.index ["taxeable_id", "taxeable_type", "available"], name: "index_taxes_on_taxeable_id_and_taxeable_type_and_available", unique: true, where: "available"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "password_digest", null: false
    t.string "avatar", default: "/images/default_avatar.png", null: false
    t.string "email", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "role", default: 0, null: false
    t.boolean "available", default: true, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "categories"
  add_foreign_key "categories", "companies"
  add_foreign_key "images", "companies"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "users", "companies"
end
