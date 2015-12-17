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
  end

  def date_format(date)
    if date.class == Date
      date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    else
      date.to_s
    end
  end

  def encrypt(message)
    breakdown = message.downcase.chars
    counter = -1
    encrypted = breakdown.map do |letter|
      counter += 1
     if counter % 4 == 0 || counter == 0
       @characters[((@characters.index(letter) + @a_offset) % 39)]
     elsif counter % 4 == 1 || counter == 1
       @characters[((@characters.index(letter) + @b_offset) % 39)]
     elsif counter % 4 == 2 || counter == 2
       @characters[((@characters.index(letter) + @c_offset) % 39)]
     elsif counter % 4 == 3 || counter == 3
       @characters[((@characters.index(letter) + @d_offset) % 39)]
     end
   end
   encrypted.join
  end

end
#
# file_to_read = ARGV[0]
# file_to_write = ARGV[1]
#
# message_in = File.read(file_to_read).chomp
#
# e = Encryptor.new(message_in)
# rand_key = e.key.key
# date = e.date
# new_message = e.encrypt(message_in)
#
#
# File.write(file_to_write, new_message)
# puts "Created #{file_to_write} with key of #{rand_key} and date #{date}"
