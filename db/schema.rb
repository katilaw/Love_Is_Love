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

ActiveRecord::Schema.define(version: 20160126164906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "story_id",   null: false
    t.integer  "creator_id", null: false
  end

  add_index "comments", ["creator_id"], name: "index_comments_on_creator_id", using: :btree
  add_index "comments", ["story_id"], name: "index_comments_on_story_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "body",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id",  null: false
    t.string   "story_photo"
  end

  add_index "stories", ["creator_id"], name: "index_stories_on_creator_id", using: :btree

  create_table "story_links", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "requestor_id",    null: false
    t.integer  "requestee_id",    null: false
    t.string   "requestee_title", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "story_links", ["requestee_id"], name: "index_story_links_on_requestee_id", using: :btree
  add_index "story_links", ["requestor_id"], name: "index_story_links_on_requestor_id", using: :btree
  add_index "story_links", ["user_id"], name: "index_story_links_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
