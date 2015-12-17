require 'pry'
require './lib/encryptor'
require './lib/decryptor'
require './lib/crack'
require './lib/key_generator'

class Enigma

  def initialize(message, key = nil, date)
    @message = message
    @key = key
    @date = date
  end

  def encrypt
    Encryptor.new(@message, @key, @date).encrypt(@message)
  end

  def decrypt
    Decryptor.new(@message, @key, @date).decrypt(@message)
  end

  def crack
    Crack.new(@message, @date).crack_decrypt
  end

end
