class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |x|
      x.string :name
    end
  end

  def down
    drop_table :players
  end
end
