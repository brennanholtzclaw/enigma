require 'minitest/autorun'
require 'minitest/pride'
require './lib/crack'

class CrackTest < Minitest::Test

  def setup
    @c = Crack.new("7knnvmkxttkaytt", 131215) #"message ..end.."
  end

  def test_it_finds_the_last_four_characters_of_message
    assert_equal "aytt", @c.find_last_four_chars
  end

  def test_it_finds_offset_from_last_encoded_letter_to_dot
    assert_equal 18, @c.a_crack_offset
  end

  def test_it_finds_offset_from_next_to_last_encoded_letter_to_dot
    assert_equal 18, @c.b_crack_offset
  end

  def test_it_finds_offset_from_third_to_last_encoded_letter_to_d
    assert_equal -21, @c.c_crack_offset
  end

  def test_it_finds_offset_from_fourth_to_last_encoded_letter_to_d
    assert_equal 13, @c.d_crack_offset
  end

  def test_it_cracks
    assert_equal "message ..end..", @c.crack_decrypt
  end

end
