class AddMultipleFieldsToPlayers < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :nick_name
      t.integer :steam_id
      t.string :main_role, null: false, default: ""
      t.string :minor_role, null: false, default: ""
      t.string :country
      t.string :region
      t.boolean :active, null: false, default: true
      t.integer :fantasy_point, null: false, default: 0
      t.string :dotabuff_url
      t.decimal :player_accumulated_pool, null: false, default: 0
      t.string :image_url
      t.text :summary
      t.float :avg_kda
      t.float :avg_gpm
      t.float :avg_xpm
      t.float :avg_kills
      t.float :avg_deaths
      t.float :avg_assists
    end

    create_table :megagames do |t|
      t.string :home_team, null: false, default: ""
      t.string :away_team, null: false, default: ""
      t.string :home_team_id
      t.string :away_team_id
      t.string :winner, null: false, default: ""
      t.string :loser, null: false, default: ""
      t.integer :which_game
      t.decimal :pool

      t.timestamps null:false
    end

    create_table :games do |t|
      t.string :radiance_team_id
      t.string :dire_team_id
      t.string :radiance_team_name, null: false, default: ""
      t.string :dire_team_name, null: false, default: ""
      t.string :winner
      t.string :loser
      t.datetime :actual_time_started
      t.datetime :scheduled_datetime
      t.date :scheduled_date
      t.integer :best_of
      t.time :duration
      t.references :megagame, index: true, foreign_key: true
      t.string :resultboard_id

      t.timestamps null:false
    end

    create_table :teams do |t|
      t.string :name, null: false, default: ""
      t.integer :captain
      t.integer :carry
      t.integer :mid
      t.integer :offlane
      t.integer :support_four
      t.integer :support_five
      t.integer :score, null: false, default: 0
      t.boolean :seeking, null: false, default:false
      t.string :current_game_id
      t.string :dotabuff_url
      t.decimal :team_accumulated_pool, null: false, default: 0
      t.integer :logo_url
      t.string :founder
      t.integer :num_of_wins, null: false, default: 0
      t.integer :num_of_loses, null: false, default: 0

      t.timestamps null:false
    end

    create_join_table :games, :teams do |t|
      t.index :game_id
      t.index :team_id
    end

    create_join_table :players, :teams do |t|
      t.index :player_id
      t.index :team_id
    end
  end
end