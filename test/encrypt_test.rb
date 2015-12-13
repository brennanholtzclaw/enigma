require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryptor'

class EncryptorTest < Minitest::Test


  def test_charactermap_is_loading_correctly
    e = Encryptor.new

    assert_equal "a", e.characters[0]
    assert_equal "n", e.characters[13]
    refute_equal "z", e.characters[0]
  end

  def test_you_can_pass_a_message_to_the_encryptor
    e = Encryptor.new("message")

    assert_equal "message", e.message
    refute_equal "not at all the message", e.message
  end

  def test_grabs_a_key_if_one_is_passed
    e = Encryptor.new("message", 12345)
    f = Encryptor.new

    assert_equal "12345", e.key.key
    refute_equal "12345", f.key.key
  end

  def test_grabs_a_date_whether_or_not_one_is_passed
    e = Encryptor.new("message", 12345)
    f = Encryptor.new("message", 12345, 160886)

    assert_equal "131215", e.date
    assert_equal "160886", f.date
    refute_equal "069420", e.date
    refute_equal "lollol", f.date
  end

  def test_it_forms_offsets
    e = Encryptor.new("message", 12345, 160886)
# binding.pry
    assert_equal 0, e.a_offset
    assert_equal 0, e.b_offset
    assert_equal 0, e.c_offset
    assert_equal 0, e.d_offset
  end
  # def test_encrypts_a_single_letter_string
  #   e = Encryptor.new("message", 12345, 131215)
  #
  #   assert_equal "s", e.encrypt("a")
  # end

end
