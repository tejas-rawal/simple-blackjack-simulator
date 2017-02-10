require 'test/unit'
require '../lib/card'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end

  def test_card_value_is_correct
    assert_equal @card.value, 10
  end

  def test_card_is_not_ace
    assert_equal @card.is_ace, false
  end

  def test_card_is_not_hidden
    assert_equal @card.is_hidden, false
  end

  def test_card_is_hidden
    @card.hide
    assert_equal @card.is_hidden, true
  end
end
