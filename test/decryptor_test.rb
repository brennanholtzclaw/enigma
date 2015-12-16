require './test/test_helper'
require 'date'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/decryptor'

class DecryptorTest < Minitest::Test


  def test_charactermap_is_loading_correctly
    d = Decryptor.new

    assert_equal "a", d.characters[0]
    assert_equal "n", d.characters[13]
    refute_equal "z", d.characters[0]
  end

  def test_grabs_a_key_if_one_is_passed
    d = Decryptor.new("message", 12345)
    f = Decryptor.new

    assert_equal "12345", d.key.key
    refute_equal "12345", f.key.key
  end

  def test_grabs_a_date_whether_or_not_one_is_passed
    d = Decryptor.new("message", 12345)
    f = Decryptor.new("message", 12345, 160886)

    t = Date.today
    today = t.strftime("%d") + t.strftime("%m") + t.strftime("%y")

    assert_equal today, d.date
    assert_equal "160886", f.date
    refute_equal "069420", d.date
    refute_equal "lollol", f.date
  end

  def test_it_forms_offsets
    d = Decryptor.new("message", "12345", "131215")

    assert_equal 18, d.a_offset
    assert_equal 25, d.b_offset
    assert_equal 36, d.c_offset
    assert_equal 50, d.d_offset
  end

  def test_encrypts_a_single_letter_string
    d = Decryptor.new("message", 12345, 131215)

    assert_equal "a", d.decrypt("s")
    refute_equal "s", d.decrypt("s")
  end

  def test_encrypts_two_letters
    d = Decryptor.new("message", 12345, 131215)

    assert_equal "ab", d.decrypt("s0")
  end

  def test_encrypts_four_letters
    d = Decryptor.new("message", 12345, 131215)

    assert_equal "abcd", d.decrypt("s0,o")
  end

  def test_encryption_should_be_the_same_every_four_letters
    d = Decryptor.new("message", 12345, 131215)

    assert_equal "abcdabcdabcdabcd", d.decrypt("s0,os0,os0,os0,o")
  end

  def test_encrypt_will_return_a_space
    d = Decryptor.new("message", 12345, 131215)

    assert_equal "s", d.decrypt(" ")
    refute_equal " ", d.decrypt("a")
  end

  def test_a_different_key_returns_different_encryption
    d = Decryptor.new("message", 54321, 131215)

    refute_equal "a", d.decrypt("s")
    refute_equal "s", d.decrypt("s")
  end

  def test_a_different_date_returns_different_encryption
    d = Decryptor.new("message", 54321, 160886)

    refute_equal " ", d.decrypt("s")
    refute_equal "s", d.decrypt("a")
  end

  def test_it_decrypts_a_long_phrase
    d = Decryptor.new("message", 54321, 160886)

    refute_equal " ", d.decrypt(",ukgqkgqtqnc6tqdu4tgxq,ut,qaktu,q6c,qx64q4ktu,")
  end

end
