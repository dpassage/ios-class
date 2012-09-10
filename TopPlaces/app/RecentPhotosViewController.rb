class RecentPhotosViewController < UITableViewController


  def photos
    FlickrPhoto.get_photo_history
  end

  def init
     initWithStyle UITableViewStylePlain
  end

  def viewDidLoad
    self.title = "Recents"
  end

  def viewWillAppear(animated)
    self.tableView.reloadData
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
    pvc = PhotoViewController.alloc.init
    pvc.photo = self.photos[indexPath.row]
    self.navigationController.pushViewController(pvc, animated:true)
  end

end
