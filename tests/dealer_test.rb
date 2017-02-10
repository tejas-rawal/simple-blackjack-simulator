require  'test/unit'
require '../lib/dealer'
require '../lib/card'

class DealerTest < Test::Unit::TestCase
  def setup
    @dealer = Dealer.new
    @king_clubs = Card.new(:clubs, :king, 10)
    @five_diamonds = Card.new(:diamonds, :five, 5)
    @eight_hearts = Card.new(:hearts, :eight, 8)
  end

  def test_hide_hole_card
    add_cards(@king_clubs, @five_diamonds)
    @dealer.hide_hole_card

    assert_equal @dealer.hand.cards[Dealer::HOLE_CARD].is_hidden, true
  end

  def test_show_hole_card
    add_cards(@king_clubs, @five_diamonds)
    @dealer.hide_hole_card
    @dealer.show_hole_card

    assert_equal @dealer.hand.cards[Dealer::HOLE_CARD].is_hidden, false
  end

  def test_dealer_should_continue_playing
    add_cards(@king_clubs, @five_diamonds)
    assert_equal @dealer.continue_playing?, true
  end

  def test_dealer_should_not_continue_playing
    add_cards(@king_clubs, @five_diamonds, @eight_hearts)
    assert_equal @dealer.continue_playing?, false
  end

  private

  def add_cards(*cards)
    cards.each { |card| @dealer.hand.add(card) }
  end
end
