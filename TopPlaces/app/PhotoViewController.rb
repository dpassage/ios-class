class PhotoViewController < UIViewController
  def photo
    @photo
  end
  def photo=(newphoto)
    @photo = newphoto
  end

  # override viewWillAppear to get the dimensions of the view for sizing the image
  # be sure to call super first
  #
  def viewWillAppear(animated)
    super

    iv = UIImageView.alloc.initWithImage(self.photo.image)
    iv.frame = self.view.bounds
    self.view.addSubview(iv)
  end
  # override loadview to set self.view to a scrollview

  def loadView
    app_frame = UIScreen.mainScreen.applicationFrame
    content_view = UIView.alloc.initWithFrame(app_frame)
    content_view.backgroundColor = UIColor.blackColor
    content_view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                    UIViewAutoresizingFlexibleWidth |
                                    UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleHeight |
                                    UIViewAutoresizingFlexibleBottomMargin
    self.view = content_view
  end
end
