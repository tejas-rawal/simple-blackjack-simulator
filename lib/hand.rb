class Hand
  attr_accessor :cards, :value
  BLACKJACK = 21
  ACE_HIGH_INDEX = 0
  ACE_LOW_INDEX = 1
  NEW_DEAL = 2

  def initialize
    reset
  end

  def reset
    @cards = []
    @value = 0
  end

  def set_value
    @value = @cards.reduce(0) do |sum, card|
      if !card.is_hidden
        card.is_ace ? handle_ace(sum, card) : sum + card.value
      else
        sum
      end
    end
  end

  def sort_cards
    # sort cards by value. Aces will be at the end of the array
    @cards.sort_by! do |card|
      card.is_ace ? card.value[ACE_HIGH_INDEX] : card.value
    end
  end

  def add(card)
    @cards << card
    sort_cards
    set_value
  end

  def handle_ace(total, ace)
    ace_value = total < 11 ? ace.value[ACE_HIGH_INDEX] : ace.value[ACE_LOW_INDEX]
    total + ace_value
  end

  def is_bust?
    @value > BLACKJACK
  end

  def is_blackjack?
    @cards.any? { |card| card.is_ace } && @cards.length == NEW_DEAL && @value == BLACKJACK
  end
end
