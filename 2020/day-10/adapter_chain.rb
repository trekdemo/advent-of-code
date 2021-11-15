#!/usr/bin/env ruby

class AdapterChain
  attr_reader :adapters, :chain

  OUTLET_RATING = 0
  BUILTIN_RATING = 3

  def initialize(*adapters)
    @adapters = adapters
    @chain = [OUTLET_RATING, *adapters.sort, rating]
    ensure_chainable!
  end

  def rating
    @rating ||= adapters.max + BUILTIN_RATING
  end

  def distribution
    @distribution ||= chain.each_with_index.each_with_object(Hash.new(0)) do |(e, i), a|
      next a if i.zero?

      a[e - chain[i - 1]] += 1
    end
  end

  def product
    distribution[1] * distribution[3]
  end

  private

  def ensure_chainable!
    chain.each_with_index.all? do |e, i|
      next true if i.zero?

      (e - chain[i - 1]) <= 3
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input.txt', mode: 'r')
  adapters = input.split(/\s/).compact.map(&:to_i)
  puts AdapterChain.new(*adapters).product
end
