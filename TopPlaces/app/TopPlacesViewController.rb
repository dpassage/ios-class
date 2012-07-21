class TopPlacesViewController < UIViewController
  def loadView
    self.view = UILabel.alloc.init
  end
  def viewDidLoad
    self.view.text = "#{self.inspect}"
  end
end
