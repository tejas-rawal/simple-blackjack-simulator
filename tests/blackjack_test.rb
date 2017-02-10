require  'test/unit'
require '../lib/blackjack'
require '../lib/card'

class BlackJackTest < Test::Unit::TestCase
  HOLE_CARD = 1
  def setup
    @blackjack = BlackJack.new
    @king_clubs = Card.new(:clubs, :king, 10)
    @queen_diamonds = Card.new(:diamonds, :queen, 10)
    @eight_hearts = Card.new(:hearts, :eight, 8)
    @six_diamonds = Card.new(:diamonds, :six, 6)
    @four_diamonds = Card.new(:diamonds, :five, 4)

  end

  def test_both_are_dealt_hands
    @blackjack.deal_hand
    assert_equal @blackjack.player.hand.cards.count, 2
    assert_equal @blackjack.dealer.hand.cards.count, 2
  end

  def test_dealer_hand_has_hole_card
    @blackjack.deal_hand
    hole_card = @blackjack.dealer.hand.cards[HOLE_CARD]

    assert_equal hole_card.is_hidden, true
  end

  def test_determines_correct_winner
    add_cards(@blackjack.player, @queen_diamonds, @six_diamonds, @four_diamonds)
    add_cards(@blackjack.dealer, @king_clubs, @eight_hearts)
    player_value = @blackjack.player.hand.value
    dealer_value = @blackjack.dealer.hand.value

    assert_equal @blackjack.determine_winner, "\n#{@blackjack.player.name} wins #{player_value} to #{dealer_value}"
  end

  private

  def add_cards(participant, *cards)
    cards.each do |card|
      participant.hand.add(card)
    end
  end
end
