#encoding: utf-8

class PracticeViewController < UIViewController
  attr_accessor :step
  attr_accessor :repeat

  DURATION = 30
  GAP = 10

  def viewDidLoad
    super

    self.title = Step.names[@step]

    rightButton = UIButton.rounded_rect
    rightButton.setTitle('Close', forState:UIControlStateNormal)
    rightButton.when(UIControlEventTouchUpInside) { dismiss_modal }
    rightButton.styleClass = 'navButton'
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(rightButton)

    imageView = UIImageView.alloc.initWithImage("step#{@step}.png".uiimage)
    imageView.frame = [[10,10], [300, 300]]

    @counter = UILabel.alloc.initWithFrame [[10, 300], [300, 100]]
    @counter.when_tapped { @paused ? resume : pause }

    view.styleId = 'practice'
    view << @counter
    view << imageView
  end

  def viewDidAppear(animated)
    super

    UIApplication.sharedApplication.idleTimerDisabled = true
    start
  end

  def viewWillDisappear(animated)
    super

    UIApplication.sharedApplication.idleTimerDisabled = false
    EM.cancel_timer(@timer) if @timer
  end

  def start
    say "step#{@step}"
    @counter.text = DURATION.to_s

    @timer = EM.add_periodic_timer 1 do
      if @paused
      else
        n = @counter.text.to_i - 1
        if n <= 0
          finished
        else
          say('10s') if n == 10
          @counter.text = n.to_s
        end
      end
    end
  end

  def pause
    return if @paused
    @paused = true
    @paused_count = @counter.text.to_i
    @counter.text = '왜 멈춰?'
  end

  def resume
    return unless @paused
    @counter.text = @paused_count.to_s
    @paused = false
  end

  def finished
    EM.cancel_timer(@timer)
    @repeat -= 1

    if @repeat <= 0
      say 'fin2'
      @counter.text = ''
      History.done(@step)
      dismiss_modal
    else
      say 'fin1'
      @counter.text = '숨 좀 돌리고...'
      EM.add_timer(GAP) { start }
    end
  end

  def say(file)
    fn = NSURL.fileURLWithPath(File.join(NSBundle.mainBundle.resourcePath, "#{file}.m4a"))
    BW::Media.play(fn) {}
  end

end