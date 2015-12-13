require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def test_enigma_grabs_random_key_when_created
    e = Enigma.new

    assert_equal 5, e.key.length
    refute_equal 0, e.key.length
  end

  def test_you_can_pass_a_key_into_enigma
    e = Enigma.new(12345)

    assert_equal "12345", e.key
    refute_equal "this is not a key", e.key
  end


end
