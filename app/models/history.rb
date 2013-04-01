class History < NanoStore::Model
  attribute :step
  attribute :created_at

  def self.today(step)
    t = NSDate.new
    find(step: step, created_at: {NSFGreaterThan => t.start_of_day, NSFLessThan => t.end_of_day}).count
  end

  def self.done(step, t = nil)
    create(step: step, created_at: t || Time.now)
  end

  def self.statistics
    ret = {}
    all.each do |history|
      d = history.created_at.string_with_style(:short)
      ret[d] ||= {}
      ret[d][history.step] ||= 0
      ret[d][history.step] += 1
    end
    ret.to_a.sort {|y, x| y[0] <=> x[0]}
  end

  def self.score(i)
    i = i.values.inject(0){|sum,i| sum+i} if i.respond_to?(:to_hash)
    [i * 100 / 20, 100].min
  end
end