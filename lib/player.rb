require_relative 'hand'

class Player
  attr_accessor :hand, :name
  DEALER_STAY_MIN = 17
  DECK_SUITES = 4
  FULL_DECK = 52

  def initialize(name)
    @name = name
    @hand = Hand.new
  end

  def display_hand
    mapped_card_values = @hand.cards.map do |card|
      if card.is_hidden
        'Card is hidden'
      else
        "#{card.name.to_s}: #{card.value}"
      end
    end

    puts "\n#{@name}'s cards: #{mapped_card_values.join(', ')}"
    puts "#{@name}'s hand value: #{@hand.value}\n"
  end

  def continue_playing?
    # keep adding cards to player unless they hit blackjack, or they bust
    !@hand.is_bust? && (@hand.value < DEALER_STAY_MIN || weighted_guess)
  end

  def weighted_guess
    # assuming the player wants a hand with at least a value of 17 (dealer minimum)
    options = Hand::BLACKJACK - @hand.value
    # probability calculation based on full deck, although in true settings the playable deck size would be lower,
    # as well as the options 
    probability = (options * DECK_SUITES).to_f / FULL_DECK
    Random.new.rand < probability
  end

  def reset_hand
    @hand.reset
  end
end
