class HistoryViewController < UIViewController
  def viewDidLoad
    @stats = History.statistics

    self.title = "History (#{@stats.count})"

    back = UIButton.rounded_rect
    back.setTitle('Back', forState:UIControlStateNormal)
    back.when(UIControlEventTouchUpInside) { navigationController.pop }
    back.styleClass = 'navButton backButton'
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(back)

    @tableview = UITableView.plain
    @tableview.separatorStyle = UITableViewCellSeparatorStyleNone
    @tableview.frame = view.bounds
    @tableview.dataSource = self
    @tableview.delegate = self

    @tableview.registerClass(HistoryCell, forCellReuseIdentifier:'history')

    view.styleId = "history"
    view << @tableview
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @stats.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('history') || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:'history')
    end

    v = @stats[indexPath.row]
    cell.textLabel.text = "#{v[0]}"
    cell.progress = History.score(v[1])
    cell
  end

end