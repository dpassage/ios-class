class PhotoViewController < UIViewController
  def photo
    @photo
  end

  def photo=(newphoto)
    @photo = newphoto
    newphoto.save_to_history
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    true
  end

  def viewWillAppear(animated)
    super
    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      image = self.photo.image
      Dispatch::Queue.main.async {
        app_frame = UIScreen.mainScreen.applicationFrame
        scroll_view = UIScrollView.alloc.initWithFrame(app_frame)
        scroll_view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleRightMargin |
                                        UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleHeight |
                                        UIViewAutoresizingFlexibleBottomMargin
        scroll_view.contentSize = CGSizeMake(320, 758)
        self.view = scroll_view

        @image_view = UIImageView.alloc.initWithImage(image)
        self.view.addSubview(@image_view)
        self.view.delegate = self
        self.view.contentSize = @image_view.bounds.size

        x_ratio = self.view.bounds.size.width / @image_view.bounds.size.width
        NSLog("x_ratio is %@", x_ratio)
        y_ratio = self.view.bounds.size.height / @image_view.bounds.size.height
        NSLog("y_ratio is %@", y_ratio)
        self.view.minimumZoomScale=[x_ratio, y_ratio].min
        self.view.maximumZoomScale=6.0
        self.view.zoomScale = [x_ratio, y_ratio].max
        self.title = self.photo.title
      }
    }
  end

  def loadView
    spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)
    spinner.startAnimating
    self.view = spinner
  end

  # UIScrollViewDelegate protocol
  def viewForZoomingInScrollView(scrollView)
    return @image_view
  end
end
