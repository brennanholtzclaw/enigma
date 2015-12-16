require 'date'
require 'pry'
require './lib/char_map'
require './lib/decryptor'

class Crack
  attr_reader :message

  def initialize(message = nil, date = nil)
    @message = message
    @date = date
    @characters = CharMap.new.characters
  end

  def find_last_four_chars
    @message[-4..-1]
  end

  def a_crack_offset
    a_off = (@characters.index(".")) - (@characters.index((find_last_four_chars[-1])))
  end

  def b_crack_offset
    b_off = (@characters.index(".")) - (@characters.index((find_last_four_chars[-2])))
  end

  def c_crack_offset
    c_off = (@characters.index("d")) - (@characters.index((find_last_four_chars[-3])))
  end

  def d_crack_offset
    d_off = (@characters.index("n")) - (@characters.index((find_last_four_chars[-4])))
  end

  def crack_decrypt
    # 39
    breakdown = @message.downcase.reverse.chars

    decrypted = breakdown.map do |letter|
      binding.pry
     if breakdown.index(letter) % 4 == 0 || breakdown.index(letter) == 0
       @characters[((@characters.index(letter) + a_crack_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 1 || breakdown.index(letter) == 1
       @characters[((@characters.index(letter) + b_crack_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 2 || breakdown.index(letter) == 2
       @characters[((@characters.index(letter) + c_crack_offset) % 39)]
     elsif breakdown.index(letter) % 4 == 3 || breakdown.index(letter) == 3
       @characters[((@characters.index(letter) + d_crack_offset) % 39)]
     end
   end
   decrypted.reverse.join
  end

end


# 'crack should first look at the last four letters of the message, and find the
# rotation to make those line up with "nd.." respectively. Then you would decrypt
# the message in reverse. build backwards and use the next three characters to validate
# your key (those should be able to use the same rotation as the first(last) three
# characters to return "..e"). Then continue to build backwards from there.
# To test, encrypt a message and pass Crack the encrypted message and a date, no key.
