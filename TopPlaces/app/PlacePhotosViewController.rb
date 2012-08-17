class PlacePhotosViewController < UITableViewController


  def place=(place)
    @place = place
  end

  def place
    @place
  end

  def photos
    @photos ||= FlickrFetcher.photosInPlace(self.place, maxResults:50).map { |p| FlickrPhoto.new(p) }
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
    photo = self.photos[indexPath.row]
    cell.textLabel.text = photo.title
    cell.detailTextLabel.text = photo.description
    cell
  end

  # UITableViewDelegate protocol methods

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    NSLog("Row %@ was tapped", indexPath.row)
    # prepare the new vc
    pvc = PhotoViewController.alloc.init
    pvc.photo = self.photos[indexPath.row]
    self.navigationController.pushViewController(pvc, animated:true)
    # push it onto the stack
  end

end
