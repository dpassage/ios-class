class PlacePhotosViewController < ItemListViewController

  def place=(place)
    @place = place
  end

  def place
    @place
  end

  def item=(place)
    self.place = place
  end

  def items
    @items ||= []
  end

  def items=(items)
    if (@items != items)
      @items = items
      self.tableView.reloadData if (self.tableView.window)
    end
  end

  def reload_items
    self.items = []
    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      photo_array = self.place.photos(50)
      Dispatch::Queue.main.async {
        self.items = photo_array
        refresh_done
      }
    }

  end

  def cell_name
    "Photo Cell"
  end

  def viewWillAppear(animated)
    super

    refresh(nil)
  end

  def viewDidLoad
    self.title = self.place.title
  end

end
