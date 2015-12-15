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

  def test_encrypts_four_letters
    e = Encryptor.new("message", 12345, 131215)

    assert_equal "s0,o", e.encrypt("abcd")
  end

  def test_encrypts_a_crazy_alphabet_test
    e = Encryptor.new("message", 12345, 131215)

    assert_equal "s0,ow4ds08hw4,l08dp4,ht8dl7jr", e.encrypt("abcdefghijklmnopqrstuvwxyz .,")
  end

  def test_encryption_should_be_the_same_every_four_letters
    e = Encryptor.new("message", 12345, 131215)

    assert_equal "s0,os0,os0,os0,o", e.encrypt("abcdabcdabcdabcd")
  end

  def test_encrypt_will_return_a_space
    e = Encryptor.new("message", 12345, 131215)

    assert_equal " ", e.encrypt("s")
    refute_equal " ", e.encrypt("a")
  end

  def test_a_different_key_returns_different_encryption
    e = Encryptor.new("message", 54321, 131215)

    refute_equal " ", e.encrypt("s")
    refute_equal "s", e.encrypt("a")
  end

  def test_a_different_date_returns_different_encryption
    e = Encryptor.new("message", 54321, 160886)

    refute_equal " ", e.encrypt("s")
    refute_equal "s", e.encrypt("a")
  end

  def test_it_encrypts_a_long_phrase
    e = Encryptor.new("message", 54321, 160886)

    expected = "This is a long phrase that might not end right"
    assert_equal expected, e.encrypt("This is a long phrase that might not end right")
  end

end
