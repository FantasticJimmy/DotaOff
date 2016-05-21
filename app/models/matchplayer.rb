  # create_table "matchplayers", force: :cascade do |t|
  #   t.integer  "game_id"
  #   t.string   "uid"
  #   t.text     "hero"
  #   t.integer  "level"
  #   t.integer  "kills"
  #   t.integer  "deaths"
  #   t.integer  "assists"
  #   t.integer  "last_hits"
  #   t.integer  "denies"
  #   t.integer  "gold"
  #   t.integer  "gpm"
  #   t.integer  "xpm"
  #   t.string   "status"
  #   t.integer  "gold_spent"
  #   t.integer  "hero_damage"
  #   t.integer  "tower_damage"
  #   t.integer  "hero_healing"
  #   t.text     "items"
  #   t.integer  "slot"
  #   t.boolean  "radiant",      null: false
  #   t.datetime "created_at",   null: false
  #   t.datetime "updated_at",   null: false
  # end
  
class Matchplayer < ActiveRecord::Base
  belongs_to :match

  serialize :hero
  serialize :items
  serialize :additional_units
  serialize :ability_upgrades

  def abandoned_or_not_connected?
    status != 'played'
  end
end