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

ActiveRecord::Schema.define(:version => 20120420201857) do

  create_table "color_groups", :force => true do |t|
    t.text     "displayname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "color_hues", :force => true do |t|
    t.integer  "color_group_id"
    t.float    "distance"
    t.integer  "h"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "color_hues", ["color_group_id"], :name => "index_color_hues_on_color_group_id"

  create_table "color_saturations", :force => true do |t|
    t.integer  "color_group_id"
    t.float    "distance"
    t.integer  "s"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "color_saturations", ["color_group_id"], :name => "index_color_saturations_on_color_group_id"

  create_table "color_values", :force => true do |t|
    t.integer  "color_group_id"
    t.float    "distance"
    t.integer  "v"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "color_values", ["color_group_id"], :name => "index_color_values_on_color_group_id"

  create_table "fixtures", :force => true do |t|
    t.integer  "galaxy_id"
    t.integer  "color_hue_id"
    t.integer  "color_saturation_id"
    t.integer  "color_value_id"
    t.float    "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fixtures", ["color_hue_id"], :name => "index_fixtures_on_color_hue_id"
  add_index "fixtures", ["color_saturation_id"], :name => "index_fixtures_on_color_saturation_id"
  add_index "fixtures", ["color_value_id"], :name => "index_fixtures_on_color_value_id"
  add_index "fixtures", ["galaxy_id"], :name => "index_fixtures_on_galaxy_id"

  create_table "galaxies", :force => true do |t|
    t.text     "displayname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
