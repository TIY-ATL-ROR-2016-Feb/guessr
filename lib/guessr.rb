require "pry"

require "guessr/version"
require "guessr/init_db"
require "guessr/player"
require "guessr/game"
require "guessr/score"

module Guessr
  class App
    def prompt(message, regex)
      puts message
      input = gets.chomp
      until input =~ regex
        puts "Sorry, that is invalid input. Please try again."
        puts message
        input = gets.chomp
      end
      input
    end

    def login
      name = prompt("What's your name, player?", /^[a-z]{4,20}$/i)
      Player.find_or_create_by(name: name)
    end

    def play(game)
      until game.finished?
        guess = game.take_turn
        exit if guess == "Q"
        game.update(last_guess: guess.to_i)
        game.update(finished: true) if game.answer == guess.to_i
      end
    end

    def new_game(player)
      game = Game.create(answer: rand(100), player_id: player.id)
      play(game)
    end

    def resume_game(player)
      games = Game.where(player_id: player.id, finished: false)
      games.each do |game|
        puts "Game (id: #{game.id}, last guess: #{game.last_guess})"
      end
      puts "Please tell us the Game ID you'd like to resume."
      game_id = gets.chomp.to_i
      game = Game.find(game_id)
      play(game)
    end

    def view_scores
    end

    def choose_game_mode(player)
      puts "\n ** What would you like to do? ** \n"
      choice = prompt("1) Play New Game\n2) Resume Game\n3) View Scores\n4) Quit\n", /^[1,2,3,4]$/)
      case choice.to_i
      when 1
        new_game(player)
      when 2
        resume_game(player)
      when 3
        view_scores
      when 4
        puts "Goodbye. Thanks for wasting time with me."
        exit
      end
    end

    def run
      player = login
      while true
        choose_game_mode(player)
      end
    end
  end
end

app = Guessr::App.new
app.run

