# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151009090232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "gallery_items", force: :cascade do |t|
    t.string   "title",       null: false
    t.integer  "rate"
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gallery_items", ["category_id"], name: "index_gallery_items_on_category_id", using: :btree
  add_index "gallery_items", ["title"], name: "index_gallery_items_on_title", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image_file_name",    null: false
    t.string   "title"
    t.string   "image_content_type", null: false
    t.integer  "image_file_size",    null: false
    t.integer  "imageable_id",       null: false
    t.string   "imageable_type",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", unique: true, using: :btree

end
