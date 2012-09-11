class PlacePhotosViewController < PhotoListViewController

  def place=(place)
    @place = place
  end

  def place
    @place
  end

  def photos
    @photos ||= []
  end

  def photos=(photos)
    if (@photos != photos)
      @photos = photos
      self.tableView.reloadData if (self.tableView.window)
    end
  end

  def viewWillAppear(animated)
    super

    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      photo_array = self.place.photos(50)
      Dispatch::Queue.main.async {
        self.photos = photo_array
      }
    }
  end

  def viewDidLoad
    self.title = self.place.title
  end

end
