require 'pry'
require 'date'
require './lib/key_generator'
require './lib/char_map'
require './lib/offset_calculator'

class Decryptor
  attr_reader :characters, :key, :date, :message, :offsets,
              :a_offset, :b_offset, :c_offset, :d_offset

  def initialize(message = nil, key = rand(99999), date = Date.today)
    @key = KeyGenerator.new(key)
    @characters = CharMap.new.characters
    @date = date_format(date)
    @offsets = OffsetCalculator.new(key, date)
    @a_offset = @offsets.a_final_off
    @b_offset = @offsets.b_final_off
    @c_offset = @offsets.c_final_off
    @d_offset = @offsets.d_final_off
    # @message = encrypt(message)
  end

  def date_format(date)
    if date.class == Date
      date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    else
      date.to_s
    end
  end

  def decrypt(message)
    # 39
    breakdown = message.chars

    decrypted = breakdown.map do |letter|
     if breakdown.index(letter) % 4 == 0 || breakdown.index(letter) == 0
       @characters[((@characters.index(letter) - @a_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 1 || breakdown.index(letter) == 1
       @characters[((@characters.index(letter) - @b_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 2 || breakdown.index(letter) == 2
       @characters[((@characters.index(letter) - @c_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 3 || breakdown.index(letter) == 3
       @characters[((@characters.index(letter) - @d_offset) % 39)]
     end
   end
   decrypted.join

  end

end
