class StepListViewController < UIViewController
  NUMBER_OF_STEPS = 4
  #include ::Motion::Pixate::Observer

  def viewDidLoad
    super

    self.title  = '굳은 어깨관절의 스트레칭'

    history = UIButton.rounded_rect
    history.setTitle('History', forState:UIControlStateNormal)
    history.when(UIControlEventTouchUpInside) { navigationController << HistoryViewController.alloc.init }
    history.styleClass = 'navButton'
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(history)

    @scrollview = UIScrollView.alloc.initWithFrame(view.bounds.height(320))
    @scrollview.pagingEnabled = true
    @scrollview.showsVerticalScrollIndicator = false
    @scrollview.showsHorizontalScrollIndicator = false
    @scrollview.alwaysBounceVertical = false
    @scrollview.alwaysBounceHorizontal = false
    @scrollview.delegate = self
    @scrollview.setContentSize CGSizeMake(view.bounds.width * NUMBER_OF_STEPS, @scrollview.frame.height)

    1.upto(NUMBER_OF_STEPS) do |i|
      imageView = UIImageView.alloc.initWithImage("step#{i}.png".uiimage)
      imageView.frame = @scrollview.bounds.right(@scrollview.bounds.width*(i-1))
      @scrollview << imageView
    end

    @page = UIPageControl.alloc.initWithFrame @scrollview.frame.below(-40).height(40).thinner(200).right(100)
    @page.numberOfPages = NUMBER_OF_STEPS

    view.styleId = 'stepList'
    view << @scrollview
    view << @page

    btn = UIButton.rounded_rect
    btn.setTitle('Start!', forState:UIControlStateNormal)
    btn.sizeToFit
    btn.when(UIControlEventTouchUpInside) { start }
    btn.frame = @page.frame.below().left(50).down(30)
    view << btn

    @counter = UILabel.alloc.initWithFrame @scrollview.frame
    @counter.hide
    view << @counter

    #startObserving
  end

  def scrollViewDidScroll(sender)
    width = @scrollview.frame.size.width
    @page.currentPage = ((@scrollview.contentOffset.x - width/3).floor / width) + 1
  end

  def start
    controller = PracticeViewController.alloc.init
    controller.step = @page.currentPage+1
    controller.repeat = 5
    present_modal_in_nav(controller)
  end
end