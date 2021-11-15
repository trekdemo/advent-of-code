require_relative './adapter_chain'
require 'minitest/autorun'

class TestAdapterChain < Minitest::Test
  def test_adapters_attribute
    @chain = AdapterChain.new(1, 2)
    assert_equal [1, 2], @chain.adapters
  end

  def test_short
    @chain = AdapterChain.new(16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4)

    assert_equal 22, @chain.rating
    assert_equal({ 1 => 7, 3 => 5 }, @chain.distribution)
    assert_equal 35, @chain.product
  end

  def test_long
    @chain = AdapterChain.new(
      28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1,
      32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3
    )

    assert_equal 52, @chain.rating
    assert_equal({ 1 => 22, 3 => 10 }, @chain.distribution)
    assert_equal 220, @chain.product
  end
end
