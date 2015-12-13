require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test

  def test_can_pass_in_own_key
    kg = KeyGenerator.new(12345)

    assert_equal 12345, kg.key
  end

  def test_key_generator_rejects_keys_longer_than_five_chars
    kg = KeyGenerator.new(123456)

    assert_equal "Key length too long", kg.key_checker
  end

end


# @key = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
