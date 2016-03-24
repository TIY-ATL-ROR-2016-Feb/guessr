module Guessr
  class Game < ActiveRecord::Base
    belongs_to :player

    def low_or_high
      self.last_guess < self.answer ? "low" : "high"
    end

    def take_turn
      puts "To quit at any time, just type 'Q'"
      if self.last_guess
        puts "Your last guess was #{self.last_guess} and that's too damn #{self.low_or_high}"
      else
        puts "Make your first guess (1-100)."
      end
      guess = gets.chomp
    end
  end
end
