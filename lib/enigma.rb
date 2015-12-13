require 'pry'
require './lib/key_generator'

class Enigma
  # attr_reader :key, :date

  # def initialize(input_key = rand(99999), date = Date.today)
  #   k = KeyGenerator.new(input_key)
  #   @key = k.key
  #   @date = k.date
  # end

  def encrypt(message, key = nil, date = nil)
    Encryptor.new(message, key, date)
  end

  def decrypt
  end

  def crack
  end

end
