require 'minitest/autorun'
require 'minitest/pride'
require './lib/offset_calculator'

class OffsetCalculatorTest < Minitest::Test

  def test_it_accepts_key_and_date
    oc = OffsetCalculator.new("12345", "131215")

    assert_equal "12345", oc.key
    assert_equal "131215", oc.date
    refute_equal "not a key", oc.key
    refute_equal "not a date", oc.date
  end

  def test_it_calculates_offsets_for_given_date
    oc = OffsetCalculator.new("12345", "131215")
    # 6225
    assert_equal 6, oc.a_offset(oc.squared)
    assert_equal 2, oc.b_offset(oc.squared)
    assert_equal 2, oc.c_offset(oc.squared)
    assert_equal 5, oc.d_offset(oc.squared)
    refute_equal "6", oc.a_offset(oc.squared)
    refute_equal "2", oc.b_offset(oc.squared)
    refute_equal "2", oc.c_offset(oc.squared)
    refute_equal "5", oc.d_offset(oc.squared)
  end

  def test_it_calculates_rotations_for_given_key
    oc = OffsetCalculator.new("12345", "131215")
    # 6225
    assert_equal 12, oc.a_rotation(oc.key)
    assert_equal 23, oc.b_rotation(oc.key)
    assert_equal 34, oc.c_rotation(oc.key)
    assert_equal 45, oc.d_rotation(oc.key)
    refute_equal "12", oc.a_rotation(oc.key)
    refute_equal "23", oc.b_rotation(oc.key)
    refute_equal "34", oc.c_rotation(oc.key)
    refute_equal "45", oc.d_rotation(oc.key)
  end

  def test_it_calculates_final_offsets_for_given_key
    oc = OffsetCalculator.new("12345", "131215")
    # 6225
    assert_equal 18, oc.a_final_off
    assert_equal 25, oc.b_final_off
    assert_equal 36, oc.c_final_off
    assert_equal 50, oc.d_final_off
    refute_equal "12", oc.a_final_off
    refute_equal "23", oc.b_final_off
    refute_equal "34", oc.c_final_off
    refute_equal "45", oc.d_final_off
  end

end
