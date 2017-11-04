class Movie
  REGULAR     = 0.freeze
  NEW_RELEASE = 1.freeze
  CHILDREN    = 2.freeze

  attr_accessor :title, :price_code

  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end
end
