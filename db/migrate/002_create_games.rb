class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.integer :player_id, null: false
      t.integer :answer, null: false
      t.integer :turn_count, default: 0
      t.integer :last_guess
      t.boolean :finished, default: false
    end
  end

  def down
    drop_table :games
  end
end
