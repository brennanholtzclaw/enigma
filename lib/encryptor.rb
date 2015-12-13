require 'pry'
require 'date'
require './lib/key_generator'
require './lib/char_map'
require './lib/offset_calculator'

class Encryptor
  attr_reader :characters, :key, :date, :message, :offsets, :a_offset

  def initialize(message = nil, key = rand(99999), date = Date.today)
    @key = KeyGenerator.new(key)
    @characters = CharMap.new.characters
    @date = date_format(date)
    # @message = encrypt(message)
    @offsets = OffsetCalculator.new(@key, date)
    @a_offset = @offsets.a_final_off
    @b_offset = @offsets.b_final_off
    @c_offset = @offsets.c_final_off
    @d_offset = @offsets.d_final_off
  end

  def date_format(date)
    if date.class == Date
      date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    else
      date.to_s
    end
  end

  def encrypt(message)
    # 39
    # binding.pry
    message.split.each do |char|
      @characters[(@a_offset - 1)]
    end.join

  end


end
