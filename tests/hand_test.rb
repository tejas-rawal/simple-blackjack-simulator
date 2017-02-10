require 'test/unit'
require '../lib/hand'
require '../lib/card'

class HandTest < Test::Unit::TestCase
  def setup
    @hand = Hand.new
    @ace = Card.new(:spades, :ace, [11, 1])
    @seven_hearts = Card.new(:hearts, :seven, 7)
    @queen_diamonds = Card.new(:diamonds, :queen, 10)
    @six_diamonds = Card.new(:diamonds, :six, 6)
  end

  def test_initial_hand_has_no_cards_or_value
    assert_equal @hand.cards.count, 0
    assert_equal @hand.value, 0
  end

  def test_add_card_should_change_hand_value
    @hand.add(@seven_hearts)
    assert_equal @hand.cards.count, 1
    assert_equal @hand.value, 7
  end

  def test_ace_with_low_card_should_have_high_value
    add_cards(@seven_hearts, @ace)
    assert_equal @hand.cards.count, 2
    assert_equal @hand.value, 18
  end

  def test_ace_with_high_hand_value_should_have_high_value
    add_cards(@seven_hearts, @six_diamonds, @ace)
    assert_equal @hand.cards.count, 3
    assert_equal @hand.value, 14
  end

  def test_cards_should_be_sorted
    add_cards(@queen_diamonds, @ace, @seven_hearts)
    assert_equal @hand.cards.count, 3
    assert_equal @hand.cards, [@seven_hearts, @queen_diamonds, @ace]
  end

  def test_hand_hits_blackjack
    add_cards(@queen_diamonds, @ace)
    assert_equal @hand.cards.count, 2
    assert_equal @hand.is_blackjack?, true
  end

  def test_hand_is_bust
    add_cards(@seven_hearts, @six_diamonds, @queen_diamonds)
    assert_equal @hand.cards.count, 3
    assert_equal @hand.is_bust?, true
  end

  def test_hand_reset
    @hand.reset
    assert_equal @hand.cards.count, 0
    assert_equal @hand.value, 0
  end

  private
  def add_cards(*cards)
    cards.each { |card| @hand.add(card) }
  end
end
