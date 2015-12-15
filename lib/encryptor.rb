require 'pry'
require 'date'
require './lib/key_generator'
require './lib/char_map'
require './lib/offset_calculator'

class Encryptor
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

  def encrypt(message)
    # 39
    breakdown = message.chars

    a_letters = []
    b_letters = []
    c_letters = []
    d_letters = []

    breakdown.each do |letter|
     if breakdown.index(letter) % 4 == 0 || breakdown.index(letter) == 0
       a_letters << letter
     elsif breakdown.index(letter) % 4 == 1 || breakdown.index(letter) == 1
       b_letters << letter
     elsif breakdown.index(letter) % 4 == 2 || breakdown.index(letter) == 2
       c_letters << letter
     elsif breakdown.index(letter) % 4 == 3 || breakdown.index(letter) == 3
       d_letters << i
     end
    #  binding.pry
   end

    a_rotate(a_letters).join if !a_letters.empty?
    b_rotate(b_letters) if !b_letters.empty?
    c_rotate(c_letters) if !c_letters.empty?
    d_rotate(d_letters) if !d_letters.empty?

  end

  def a_rotate(input)
    a_encrypted = input.map do |char|
      i = @characters.index(char)
      @characters[(i + @a_offset)]
    end
    binding.pry
    a_encrypted
  end

  def rotate


    # message_indexes = message.chars.map do |char|
    #   @characters.index(char)
    # end
    #
    # encrypted_message = message.chars.map do |char|
    #   @characters[@a_offset]
    # end

    # encrypted_message.join

end
#
# 'HOW TO ENCRYPT A MESSAGE'
# "Take the incoming message and break it into it's characters, including spaces
# and some simple punctuation. As those pieces pass through the encryptor box
# the first one will be rotated by the 'A' Offset, the second by the 'B', the
# third by the 'C', and the fourth by the 'D'. After that the process should
# cycle through until the end of the message.
#
# You could iterate through the message array, constantly checking the index value of


"IN THE ENCRYPT METHOD ABOVE!
take the breakdown and add the encryption into the 'each do' block...
ie: if breakdown.index(letter) % 4 == 0 || breakdown.index(letter) == 0
      @characters[(@characters.index(letter) + @a_offset)]

that should end you up with an array of the encrypted letters? maybe?"
