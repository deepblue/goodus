describe History do
  before do
    NanoStore.shared_store = NanoStore.store(:memory)
  end

  it 'should add histories' do
    History.done(1)
    History.today(1).should == 1
  end

  it 'should get statistics' do
    History.done(2, NSDate.new - 1.day)
    2.times { History.done(1) }

    stats = History.statistics

    stats[0][1].values.should == [1]
    stats[1][1].values.should == [2]
  end

  it 'should calculate score' do
    History.score(5).should == 25
    History.score({1=>1, 2=>2, 3=>2}).should == 25
  end
end
