class AddMatchplayersAndOthercolumns < ActiveRecord::Migration
  def change
    add_column :players, :profile_url, :string
    add_column :players, :uid, :string

    add_column :games, :uid, :integer, index: true, unique: true, null: false 
    add_column :games, :first_blood , :integer
    add_column :games, :mode , :string
    add_column :games, :cluster , :string
    add_column :games, :match_type, :string
    remove_column :games, :duration, :time
    add_column :games,:duration, :string
    add_column :games,:likes, :integer
    add_column :games,:dislikes, :integer
    add_column :games,:towers_status, :text
    add_column :games,:barracks_status, :text
  end
end
