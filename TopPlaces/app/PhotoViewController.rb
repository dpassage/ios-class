class PhotoViewController < UIViewController
  def photo
    @photo
  end
  def photo=(newphoto)
    @photo = newphoto
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    true
  end
  # override viewWillAppear to get the dimensions of the view for sizing the image
  # be sure to call super first
  #
  def viewWillAppear(animated)
    super
    @image_view = UIImageView.alloc.initWithImage(self.photo.image)
    self.view.contentSize = @image_view.bounds.size
    self.view.minimumZoomScale=0.5
    self.view.maximumZoomScale=6.0
    self.view.addSubview(@image_view)
    self.view.delegate = self

    self.title = self.photo.title
  end
  # override loadview to set self.view to a scrollview

  def loadView
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
  end

  # UIScrollViewDelegate protocol
  def viewForZoomingInScrollView(scrollView)
    return @image_view
  end
end
