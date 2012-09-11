class PhotoListViewController < UITableViewController

  def prepareForSegue(segue, sender: sender)
    indexPath = self.tableView.indexPathForCell sender
    segue.destinationViewController.photo = self.photos[indexPath.row]
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
                                 reuseIdentifier:"Photo Cell")
    end    
    photo = self.photos[indexPath.row]
    cell.textLabel.text = photo.title
    cell.detailTextLabel.text = photo.description
    cell
  end

end
