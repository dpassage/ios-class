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
  # override loadview to set self.view to a scrollview

  def loadView
    app_frame = UIScreen.mainScreen.applicationFrame
    content_view = UIView.alloc.initWithFrame(app_frame)
    content_view.backgroundColor = UIColor.blackColor
    self.view = content_view

    label = UILabel.alloc.initWithFrame(app_frame)
    label.text = "Foo!"
    self.view.addSubview(label)
  end
end
