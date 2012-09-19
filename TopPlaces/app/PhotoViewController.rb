class PhotoViewController < UIViewController
  extend IB

  outlet :spinner, UIActivityIndicatorView
  outlet :scroll_view, UIScrollView

  def item=(newphoto)
    self.photo = newphoto
  end

  def photo
    @photo
  end

  def photo=(newphoto)
    if @photo != newphoto
      @photo = newphoto
      newphoto.save_to_history if newphoto
      load_photo if @scroll_view
    end
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    true
  end

  def viewWillAppear(animated)
    super
    load_photo
  end

  def load_photo
    if @scroll_view.subviews
      @scroll_view.subviews.each { |view| view.removeFromSuperview }
    end
    return unless self.photo

    @spinner.startAnimating
    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      image = self.photo.image
      Dispatch::Queue.main.async {

        @image_view = UIImageView.alloc.initWithImage(image)

        @scroll_view.addSubview(@image_view)
        @scroll_view.delegate = self
        @scroll_view.contentSize = @image_view.bounds.size

        x_ratio = @scroll_view.bounds.size.width / @image_view.bounds.size.width
        NSLog("x_ratio is %@", x_ratio)
        y_ratio = @scroll_view.bounds.size.height / @image_view.bounds.size.height
        NSLog("y_ratio is %@", y_ratio)
        @scroll_view.minimumZoomScale=[x_ratio, y_ratio].min
        @scroll_view.maximumZoomScale=6.0
        @scroll_view.zoomScale = [x_ratio, y_ratio].max
        self.title = self.photo.title
        @spinner.stopAnimating
      }
    }
  end

  # UIScrollViewDelegate protocol
  def viewForZoomingInScrollView(scrollView)
    return @image_view
  end
end
