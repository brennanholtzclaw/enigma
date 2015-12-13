require 'pry'

class KeyGenerator
  attr_reader :key

  def initialize(key = rand(99999))
    @key = key
    key_checker
  end

  def key_checker
    # binding.pry
    "Key length too long" if @key.to_s.length > 5
  end


end
