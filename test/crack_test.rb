require 'minitest/autorun'
require 'minitest/pride'
require './lib/crack'

class CrackTest < Minitest::Test

  def setup
    @c = Crack.new("7knfvm,xte,aye6", 131215) #"message ..end.."
  end

  def test_it_finds_the_last_four_characters_of_message
    assert_equal "aye6", @c.find_last_four_chars
  end

  def test_it_finds_rotation_from_last_encoded_letter_to_dot
    assert_equal -1, @c.a_crack_rotation
  end

  def test_it_finds_rotation_from_next_to_last_encoded_letter_to_dot
    assert_equal 31, @c.b_crack_rotation
  end

  def test_it_finds_rotation_from_third_to_last_encoded_letter_to_d
    assert_equal -23, @c.c_crack_rotation
  end

  def test_it_finds_rotation_from_fourth_to_last_encoded_letter_to_d
    assert_equal 8, @c.d_crack_rotation
  end

  def test_it_cracks_known_characters
    crack = Crack.new("qxbyvx8", 131215)
    assert_equal "..end..", crack.crack_decrypt
  end

  def test_it_cracks_i_guess
    # skip
    assert_equal "message ..end..", @c.crack_decrypt
  end

end
