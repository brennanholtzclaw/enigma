require 'pry'
require './lib/key_generator'

class OffsetCalculator
  attr_reader :key, :date, :squared

  def initialize(key, date)
    @key = key
    @date = date_format(date)
    @squared = @date.to_i ** 2
  end

  def date_format(date)
    if date.class == Date
      date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    else
      date.to_s
    end
  end

  def a_offset(squared)
    squared.to_s[-4].to_i
  end

  def b_offset(squared)
    squared.to_s[-3].to_i
  end

  def c_offset(squared)
    squared.to_s[-2].to_i
  end

  def d_offset(squared)
    squared.to_s[-1].to_i
  end

  def a_rotation(key)
    key[0..1].to_i
  end

  def b_rotation(key)
    key[1..2].to_i
  end

  def c_rotation(key)
    key[2..3].to_i
  end

  def d_rotation(key)
    key[3..4].to_i
  end

  def a_final_off
    a_offset(@squared.to_s) + a_rotation(@key.to_s)
  end

  def b_final_off
    b_offset(@squared.to_s) + b_rotation(@key.to_s)
  end

  def c_final_off
    c_offset(@squared.to_s) + c_rotation(@key.to_s)
  end

  def d_final_off
    d_offset(@squared.to_s) + d_rotation(@key.to_s)
  end

end
