class TopPlacesViewController < UITableViewController

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

  def viewWillAppear(animated)
    super

    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      place_array = FlickrFetcher.topPlaces.map { |p| FlickrPlace.new(p) }
      Dispatch::Queue.main.async {
            self.top_places = place_array.sort { |a,b| a.title <=> b.title }
      }
    }
  end

  def init
     initWithStyle UITableViewStylePlain
  end

  def prepareForSegue(segue, sender: sender)
    indexPath = self.tableView.indexPathForCell sender
    segue.destinationViewController.place = self.top_places[indexPath.row]
  end

  # UITableViewDataSource protocol methods

  def tableView(view, numberOfRowsInSection:section)
    NSLog("top_places.size is %d", self.top_places.size)
    self.top_places.size
  end

  def tableView(view, cellForRowAtIndexPath:indexPath)
    NSLog("In tableView:cellForRowAtIndexPath %@", indexPath)
    cell = self.tableView.dequeueReusableCellWithIdentifier("Top Place Cell")
    if (!cell) 
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                 reuseIdentifier:"Top Place Cell")
    end    

    cell.textLabel.text = self.top_places[indexPath.row].title
    cell.detailTextLabel.text = self.top_places[indexPath.row].description
    cell
  end

end
