class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement
    total_amount = 0.0
    frequent_renter_points = 0
    result = "Rental Record for #{@name}\n"

    @rentals.each do |r|
      this_amount = 0.0

      case r.movie.price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (r.days_rented - 2) * 1.5 if (r.days_rented > 2)
      when Movie::NEW_RELEASE
        this_amount += r.days_rented * 3
      when Movie::CHILDREN
        this_amount += 1.5
        this_amount += (r.days_rented - 3) * 1.5 if (r.days_rented > 3)
      end

      # レンタルポイントを加算
      frequent_renter_points += 1

      # 新作を２日以上借りた場合は、ボーナスポイント
      frequent_renter_points += 1 if r.movie.price_code == Movie::NEW_RELEASE && r.days_rented > 1

      result << "\t#{r.movie.title}\t#{this_amount}\n"
      total_amount += this_amount
    end

    result << "Amount owed is #{total_amount}\n"
    result << "You earned #{frequent_renter_points} frequent renter points"
  end
end
