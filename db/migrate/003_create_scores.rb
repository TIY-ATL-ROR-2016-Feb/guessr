class CreateScores < ActiveRecord::Migration
  def up
    create_table :scores do |t|
      t.integer :points, default: 0
      t.integer :player_id, null: false
      t.integer :game_count, default: 0
    end
  end

  def down
    drop_table :scores
  end
end
