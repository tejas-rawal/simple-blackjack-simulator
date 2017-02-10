require './lib/blackjack'
require './lib/deck'
require './lib/player'
require './lib/dealer'

puts "Welcome to BlackJack"
puts 'What is your name?'
name = gets.chomp

player = Player.new(name)
dealer = Dealer.new
deck = Deck.new
blackjack = BlackJack.new(player, dealer, deck)
puts blackjack.new_game
