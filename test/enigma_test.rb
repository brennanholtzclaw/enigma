require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  # def setup
  #   @e = Enigma.new("message..end..", 12345, 131215)
  # end

  def test_it_encrypts_integratively
    assert_equal "43p3s5bjq3koqx", Enigma.new("message..end..", 12345, 131215).encrypt
  end

  def test_it_decrypts_integratively
    assert_equal "message..end..", Enigma.new("43p3s5bjq3koqx", 12345, 131215).decrypt
  end

  def test_it_cracks_integratively
    assert_equal "message..end..", Enigma.new("43p3s5bjq3koqx", 131215).crack
  end

end
