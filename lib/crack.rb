require 'date'
require 'pry'
require './lib/char_map'
require './lib/decryptor'

class Crack
  attr_reader :message

  def initialize(message = nil, date = nil)
    @message = message
    @date = date.to_i
    @characters = CharMap.new.characters
    @offsets = OffsetCalculator.new(0, date)
    @key = nil
  end

  def find_last_four_chars
    @message[-4..-1]
  end

  def a_date_offset
    @offsets.a_offset(@offsets.squared)
  end

  def b_date_offset
    @offsets.b_offset(@offsets.squared)
  end

  def c_date_offset
    @offsets.c_offset(@offsets.squared)
  end

  def d_date_offset
    @offsets.d_offset(@offsets.squared)
  end

  def a_crack_rotation
    a_off = (@characters.index(".")) - ((@characters.index((find_last_four_chars[-1])) + a_date_offset))
  end

  def b_crack_rotation
    b_off = (@characters.index(".")) - ((@characters.index((find_last_four_chars[-2])) + b_date_offset))
  end

  def c_crack_rotation
    c_off = (@characters.index("d")) - ((@characters.index((find_last_four_chars[-3])) + c_date_offset))
  end

  def d_crack_rotation
    d_off = (@characters.index("n")) - ((@characters.index((find_last_four_chars[-4])) + d_date_offset))
  end

  def crack_decrypt
    # 39
    breakdown = @message.downcase.reverse.chars
    counter = -1
    decrypted = breakdown.map do |letter|
      counter += 1
     if counter % 4 == 0 || counter == 0
       @characters[((@characters.index(letter) + (a_crack_rotation + a_date_offset)) % 39)]
     elsif counter % 4 == 1 || counter == 1
       @characters[((@characters.index(letter) + (b_crack_rotation + b_date_offset)) % 39)]
     elsif counter % 4 == 2 || counter == 2
       @characters[((@characters.index(letter) + (c_crack_rotation + c_date_offset)) % 39)]
     elsif counter % 4 == 3 || counter == 3
       @characters[((@characters.index(letter) + (d_crack_rotation + d_date_offset)) % 39)]
     end
   end
   decrypted.reverse.join
  end

end

# if __FILE__ == $0
# file_to_read = ARGV[0]
# file_to_write = ARGV[1]
# message_in = File.read(file_to_read).chomp
# date = ARGV[2]
# c = Crack.new(message_in, date)
#
# new_message = c.crack_decrypt
#
# File.write(file_to_write, new_message)
# puts "Created #{file_to_write} with key of ____ and date #{date}"
# end
# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 030415
# Created 'cracked.txt' with the cracked key 82648 and date 030415
