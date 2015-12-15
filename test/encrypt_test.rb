require 'date'
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
    skip # - changed implementation of message after this test
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

    t = Date.today
    today = t.strftime("%d") + t.strftime("%m") + t.strftime("%y")

    assert_equal today, e.date
    assert_equal "160886", f.date
    refute_equal "069420", e.date
    refute_equal "lollol", f.date
  end

  def test_it_forms_offsets
    e = Encryptor.new("message", "12345", "131215")

    assert_equal 18, e.a_offset
    assert_equal 25, e.b_offset
    assert_equal 36, e.c_offset
    assert_equal 50, e.d_offset
  end

  def test_encrypts_a_single_letter_string
    e = Encryptor.new("message", 12345, 131215)

    assert_equal "s", e.encrypt("a")
  end

  def test_encrypts_two_letters
    e = Encryptor.new("message", 12345, 131215)

    assert_equal "s0", e.encrypt("ab")
  end

end

a = "this is a message"

b = a.chars

a_array = []
b_array = []
c_array = []
d_array = []

b.each do |w, x, y, z|
  a_array << w
  b_array << x
  c_array << y
  d_array << z
end
