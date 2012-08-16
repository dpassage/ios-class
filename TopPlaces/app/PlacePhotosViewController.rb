class PlacePhotosViewController < UITableViewController


  def place=(place)
    @place = place
  end

  def place
    @place
  end

  def photos
    @photos ||= FlickrFetcher.photosInPlace(self.place, maxResults:50)
  end

  def init
     initWithStyle UITableViewStylePlain
  end

  def viewDidLoad
    self.title = self.place["_content"].split(",", 2)[0]
  end

  # UITableViewDataSource protocol methods

  def tableView(view, numberOfRowsInSection:section)
    self.photos.size
  end

  def tableView(view, cellForRowAtIndexPath:indexPath)
    NSLog("In tableView:cellForRowAtIndexPath %@", indexPath)
    cell = self.tableView.dequeueReusableCellWithIdentifier("Photo Cell")
    if (!cell) 
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                 reuseIdentifier:"PhotoCell")
    end    
    place = self.top_places[indexPath.row]["_content"].split(", ", 2)
    cell.textLabel.text = place[0]
    cell.detailTextLabel.text = place[1]
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

end
