require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test

  def test_can_pass_in_own_key
    kg = KeyGenerator.new(12345)

    assert_equal "12345", kg.key
    refute_equal "54321", kg.key
  end

  def test_key_generator_rejects_keys_longer_than_five_chars
    kg = KeyGenerator.new(123456)

    assert_equal "Key length too long", kg.key_checker(kg.key)
    refute_equal "this is super wrong", kg.key_checker(kg.key)
  end

  def test_key_checker_fixes_a_key_less_than_five_characters
    kg = KeyGenerator.new(1234)

    assert_equal "01234", kg.key
    refute_equal "not at all equal", kg.key
  end

end
