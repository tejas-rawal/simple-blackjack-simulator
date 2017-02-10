class Card
  attr_accessor :suite, :name, :value, :is_ace, :is_hidden
  ACE = :ace

  def initialize(suite, name, value, is_hidden = false)
    @suite, @name, @value = suite, name, value
    @is_ace = name == ACE
    @is_hidden = is_hidden
  end

  def hide
    @is_hidden = true
  end
end
