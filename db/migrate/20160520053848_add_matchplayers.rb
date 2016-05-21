class AddMatchplayers < ActiveRecord::Migration
  def change
    create_table :matchplayers do |t|
      t.references :game, index: true, foreign_key: true
      t.string :uid
      t.text :hero
      t.integer :level
      t.integer :kills
      t.integer :deaths
      t.integer :assists
      t.integer :last_hits
      t.integer :denies
      t.integer :gold
      t.integer :gpm
      t.integer :xpm
      t.string :status
      t.integer :gold_spent
      t.integer :hero_damage
      t.integer :tower_damage
      t.integer :hero_healing
      t.text :items
      t.integer :slot
      t.boolean :radiant, null: false

      t.timestamps null: false
    end
    add_index :matchplayers, :uid
    add_index :matchplayers, :radiant
  end
end