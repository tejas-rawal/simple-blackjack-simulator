require  'test/unit'
require '../lib/player'
require '../lib/card'

class PlayerTest < Test::Unit::TestCase
  def setup
    @player = Player.new('TestPlayer')
    @jack_hearts = Card.new(:hearts, :jack, 10)
    @three_clubs = Card.new(:clubs, :three, 3)
    @nine_spades = Card.new(:spades, :nine, 9)
  end

  def test_player_should_continue_playing
    add_cards(@jack_hearts, @three_clubs)
    assert_equal @player.continue_playing?, true
  end

  def test_player_should_not_continue_playing
    add_cards(@jack_hearts, @three_clubs, @nine_spades)
    assert_equal @player.continue_playing?, false
  end

  private
  def add_cards(*cards)
    cards.each { |card| @player.hand.add(card) }
  end
end
