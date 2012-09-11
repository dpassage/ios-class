class TopPlacesViewController < ItemListViewController

  def top_places
    unless @top_places
      @top_places = []
    end
    @top_places
  end

  def top_places=(places)
    if (@top_places != places)
      @top_places = places
      self.tableView.reloadData if (self.tableView.window) 
    end
  end

  def items
    self.top_places
  end

  def reload_items
    self.top_places = []
    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      place_array = FlickrPlace.top_places
      Dispatch::Queue.main.async {
            self.top_places = place_array
            refresh_done
      }
    }

  end

  def cell_name
    "Top Place Cell"
  end

  def viewWillAppear(animated)
    super

    self.reload_items
   end

  def viewDidLoad
    self.title = "Top Places"
  end


end
