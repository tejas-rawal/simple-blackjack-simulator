require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class BlackJack
  attr_accessor :player, :dealer, :deck

  def initialize(player = Player.new('Player1') , dealer = Dealer.new, deck = Deck.new)
    @deck = deck
    @player = player
    @dealer = dealer
  end

  # Game simulation
  def new_game
    deal_hand
    @player.display_hand
    @dealer.display_hand

    # Game is immediately over if player hits blackjack
    return "\n#{@player.name} hit Blackjack #{@player.name} wins." if @player.hand.is_blackjack?

    # Simulate player hand first
    simulate_hand(@player)
    return "\n#{@player.name}'s hand is bust. #{@dealer.name} wins." if @player.hand.is_bust?
    puts "\n#{@player.name} decides to stay at #{@player.hand.value}"

    # Once player is done, dealer reveals their hole card
    @dealer.show_hole_card
    @dealer.display_hand

    # Game is over if dealer hit blackjack
    return "\n#{@dealer.name} hit Blackjack. #{@dealer.name} wins." if @dealer.hand.is_blackjack?

    # simulate dealer hand
    simulate_hand(@dealer)
    return "\n#{@dealer.name}'s hand is bust. #{@player.name} wins." if @dealer.hand.is_bust?
    puts "\n#{@dealer.name} stays at #{@dealer.hand.value}"
    # Find out who wins if neither bust or hit blackjack
    determine_winner
  end

  # Deal two cards from the deck to player and dealer
  def deal_hand
    @deck.shuffle
    @player.reset_hand
    @dealer.reset_hand

    2.times do
      [@player, @dealer].each do |competitor|
        deal_card(competitor)
      end
    end

    @dealer.hide_hole_card
  end

  def simulate_hand(player_or_dealer)
    while player_or_dealer.continue_playing?
      puts "\n#{player_or_dealer.name} decides to take card\n"
      deal_card(player_or_dealer)
      player_or_dealer.display_hand
    end
  end

  def deal_card(player_or_dealer)
    player_or_dealer.hand.add(@deck.deal_card)
  end

  def determine_winner
    dealer_value = @dealer.hand.value
    player_value = @player.hand.value

    if player_value > dealer_value
      return "\n#{@player.name} wins #{player_value} to #{dealer_value}"
    elsif player_value == dealer_value
      return "\nThe game is a tie."
    else
      return "\n#{@dealer.name} wins #{dealer_value} to #{player_value}"
    end
  end
end
