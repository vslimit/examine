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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131115032847) do

  create_table "admins", :force => true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.string   "role"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "answers", :force => true do |t|
    t.string   "sign"
    t.string   "content"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "pid"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "level"
  end

  create_table "profiles", :force => true do |t|
    t.string   "dic_key"
    t.string   "dic_value"
    t.string   "dic_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "dic_type_name"
  end

  create_table "scores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "totle_score"
    t.string   "all_score"
    t.string   "status"
    t.string   "reason"
    t.string   "exam_date"
    t.string   "air"
    t.string   "subjects"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "title"
    t.string   "answer"
    t.string   "air"
    t.string   "code"
    t.integer  "category_id"
    t.string   "subject_type", :limit => 11
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "tag"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "score"
    t.string   "status"
    t.string   "reason"
    t.string   "card_no"
    t.string   "exam_date"
    t.string   "air"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "session_id"
    t.string   "on_line"
  end

end
