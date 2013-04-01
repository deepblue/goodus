class HistoryCell < UITableViewCell
  attr_accessor :progress

  def initWithStyle(style, reuseIdentifier:cell_identifier)
    super

    @progress1 = UILabel.alloc.initWithFrame [[100,10], [100,21]]
    @progress1.styleClass = 'progress1'

    @progress2 = UIView.alloc.initWithFrame [[200,10], [100,21]]
    @progress2.styleClass = 'progress2'

    @label = UILabel.alloc.initWithFrame [[120, 10], [160, 21]]
    @label.styleClass = 'progressLabel'
    @label.backgroundColor = UIColor.clearColor

    contentView << @progress1
    contentView << @progress2
    contentView << @label

    self
  end

  def progress=(v)
    @progress = v
    @label.text = "#{v}%"

    @progress1.frame = [[100,10], [v*2,21]]
    @progress2.frame = [[100+v*2,10], [200-v*2,21]]
  end
end