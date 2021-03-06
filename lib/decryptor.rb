require 'pry'
require 'date'
require './lib/key_generator'
require './lib/char_map'
require './lib/offset_calculator'

class Decryptor
  attr_reader :characters, :key, :date, :message, :offsets

  def initialize(message = nil, key = rand(99999), date = Date.today)
    @key = KeyGenerator.new(key)
    @characters = CharMap.new.characters
    @date = date_format(date)
    @offsets = OffsetCalculator.new(key, date)
  end

  def date_format(date)
    if date.class == Date
      date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    else
      date.to_s
    end
  end

  def a_offset
    @offsets.a_final_off
  end

  def b_offset
    @offsets.b_final_off
  end

  def c_offset
    @offsets.c_final_off
  end

  def d_offset
    @offsets.d_final_off
  end

  def decrypt(message)
    breakdown = message.downcase.chars

    decrypted = breakdown.map do |letter|
     if breakdown.index(letter) % 4 == 0 || breakdown.index(letter) == 0
       @characters[((@characters.index(letter) - a_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 1 || breakdown.index(letter) == 1
       @characters[((@characters.index(letter) - b_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 2 || breakdown.index(letter) == 2
       @characters[((@characters.index(letter) - c_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 3 || breakdown.index(letter) == 3
       @characters[((@characters.index(letter) - d_offset) % 39)]
     end
   end
   decrypted.join
  end

end
#
# file_to_read = ARGV[0]
# file_to_write = ARGV[1]
# message_in = File.read(file_to_read).chomp
# key = ARGV[2]
# date = ARGV[3]
# d = Decryptor.new(message_in, key, date)
#
# new_message = d.decrypt(message_in)
#
# File.write(file_to_write, new_message)
# puts "Created #{file_to_write} with key of #{key} and date #{date}"
#
# ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 030415
# Created 'decrypted.txt' with the key 82648 and date 030415
