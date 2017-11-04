# Dir.pwdは、プロジェクトのroot直下で実行する想定
Dir[File.expand_path('video_rental', Dir.pwd) << '/*.rb'].each { |f| require f }

describe Customer do
  describe '#statement' do
    let(:customer) do
      build(:customer).tap { |c| c.add_rental(rental) }
    end

    subject { customer.statement }

    context '新作ビデオを1日借りた場合' do
      let(:rental) { build(:rental, :new_release, days_rented: 1) }
      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{rental.movie.title}\t3.0
          Amount owed is 3.0
          You earned 1 frequent renter points
                          EOS
                       )
      end
    end

    context '新作ビデオを2日借りた場合' do
      let(:rental) { build(:rental, :new_release, days_rented: 2) }
      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{rental.movie.title}\t6.0
          Amount owed is 6.0
          You earned 2 frequent renter points
                          EOS
                       )
      end
    end

    context '通常ビデオ2日借りた場合' do
      let(:rental) { build(:rental, :regular, days_rented: 2) }
      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{rental.movie.title}\t2.0
          Amount owed is 2.0
          You earned 1 frequent renter points
                          EOS
                       )
      end
    end

    context '通常ビデオで3日借りた場合' do
      let(:rental) { build(:rental, :regular, days_rented: 3) }
      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{rental.movie.title}\t3.5
          Amount owed is 3.5
          You earned 1 frequent renter points
                          EOS
                       )
      end
    end

    context '子供向けビデオを3日借りた場合' do
      let(:rental) { build(:rental, :children, days_rented: 3) }
      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{rental.movie.title}\t1.5
          Amount owed is 1.5
          You earned 1 frequent renter points
                          EOS
                       )
      end
    end

    context '子供向けビデオで4日借りた場合' do
      let(:rental) { build(:rental, :children, days_rented: 4) }
      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{rental.movie.title}\t3.0
          Amount owed is 3.0
          You earned 1 frequent renter points
                          EOS
                       )
      end
    end

    context '通常、新作、子供向けのビデオを借りた場合' do
      let(:customer) do
        build(:customer).tap do |c|
          c.add_rental(regular_rental)
          c.add_rental(new_release_rental)
          c.add_rental(children_rental)
        end
      end

      let(:regular_rental)      { build(:rental, :regular, days_rented: 1) }
      let(:new_release_rental)  { build(:rental, :new_release, days_rented: 1) }
      let(:children_rental)     { build(:rental, :children, days_rented: 1) }

      it do
        is_expected.to eq(<<~"EOS".chomp
          Rental Record for #{customer.name}
          \t#{regular_rental.movie.title}\t2.0
          \t#{new_release_rental.movie.title}\t3.0
          \t#{children_rental.movie.title}\t1.5
          Amount owed is 6.5
          You earned 3 frequent renter points
                          EOS
                       )
      end
    end
  end
end
