
  # create_table "players", force: :cascade do |t|
  #   t.string   "email",                   default: "",   null: false
  #   t.string   "encrypted_password",      default: "",   null: false
  #   t.string   "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.integer  "sign_in_count",           default: 0,    null: false
  #   t.datetime "current_sign_in_at"
  #   t.datetime "last_sign_in_at"
  #   t.inet     "current_sign_in_ip"
  #   t.inet     "last_sign_in_ip"
  #   t.datetime "created_at",                             null: false
  #   t.datetime "updated_at",                             null: false
  #   t.string   "first_name",              default: "",   null: false
  #   t.string   "last_name",               default: "",   null: false
  #   t.string   "nick_name"
  #   t.integer  "steam_id"
  #   t.string   "main_role",               default: "",   null: false
  #   t.string   "minor_role",              default: "",   null: false
  #   t.string   "country"
  #   t.string   "region"
  #   t.boolean  "active",                  default: true, null: false
  #   t.integer  "fantasy_point",           default: 0,    null: false
  #   t.string   "dotabuff_url"
  #   t.decimal  "player_accumulated_pool", default: 0.0,  null: false
  #   t.string   "image_url"
  #   t.text     "summary"
  #   t.float    "avg_kda"
  #   t.float    "avg_gpm"
  #   t.float    "avg_xpm"
  #   t.float    "avg_kills"
  #   t.float    "avg_deaths"
  #   t.float    "avg_assists"
  # end

require './lib/utils'
class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :games

  include Utils
  def self.from_omniauth(auth)
      info = auth['info']
      # Convert from 64-bit to 32-bit
      player = Player.find_or_initialize_by(uid: (auth['uid'].to_i - 76561197960265728).to_s)
      player.nick_name = info['nickname']
      player.image_url = info['image']
      player.profile_url = info['urls']['Profile']
      player.save!
      player
  end

  def won?(match)
    player = find_self_in(match)
    (player.radiant? && match.winner == 'Radiant') || (!player.radiant? && match.winner == 'Dire')
  end

  def played_for_in(match)
    find_self_in(match).hero
  end

  def load_matches!(count)
    matches_arr = Dota.api.matches(player_id: self.uid, limit: count)
    if matches_arr && matches_arr.any?
      matches_arr.each do |match|
        unless self.games.where(uid: match.id).any?
          match_info = nil
          loop do
            # Sometimes Steam API returns nothing in response
            match_info = Dota.api.matches(match.id)
            break if match_info && match_info.id
          end
          new_game = self.games.create({
                                            uid: match.id,
                                            winner: match_info.winner.to_s.titleize,
                                            first_blood: parse_duration(match_info.first_blood),
                                            started_at: match_info.starts_at,
                                            mode: match_info.mode,
                                            cluster: match_info.cluster,
                                            duration: parse_duration(match_info.duration),
                                            match_type: match_info.type,
                                            likes: match_info.positive_votes,
                                            dislikes: match_info.negative_votes,
                                            towers_status: {
                                              radiant: parse_buildings(match_info.radiant.tower_status),
                                              dire: parse_buildings(match_info.dire.tower_status)
                                            },
                                            barracks_status: {
                                              radiant: parse_buildings(match_info.radiant.barracks_status),
                                              dire: parse_buildings(match_info.dire.barracks_status)
                                            }
                                          })
          new_game.load_players!(match_info.radiant, match_info.dire)
        end
      end
    end
  end

  private

  def find_self_in(match)
    match.players.find_by(uid: uid)
  end

  def parse_buildings(arr)
    arr.keep_if {|k, v| v }.keys
  end
end