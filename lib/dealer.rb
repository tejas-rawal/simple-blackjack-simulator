require_relative 'player'
require_relative 'hand'

class Dealer < Player
  attr_accessor :hand
  HOLE_CARD = 1

  def initialize
    @name = 'Dealer'
    @hand = Hand.new
  end

  def should_dealer_stay?
    hand_value = @hand.value
    hand_value >= DEALER_STAY_MIN && hand_value <= Hand::BLACKJACK
  end

  def hide_hole_card
    @hand.cards[HOLE_CARD].is_hidden = true
    @hand.set_value
  end

  def show_hole_card
    @hand.cards[HOLE_CARD].is_hidden = false
    @hand.set_value
  end

  def continue_playing?
    # Keep adding cards until dealer either busts, or has to stay
    !@hand.is_bust? && !should_dealer_stay?
  end
end
