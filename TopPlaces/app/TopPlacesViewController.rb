class TopPlacesViewController < UITableViewController

  def top_places
    unless @top_places
      place_array = FlickrFetcher.topPlaces
      @top_places = place_array.sort { |a,b| a["_content"] <=> b["_content"] }
    end
    @top_places
  end

  def init
     initWithStyle UITableViewStylePlain
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
    place = self.top_places[indexPath.row]["_content"].split(", ", 2)
    cell.textLabel.text = place[0]
    cell.detailTextLabel.text = place[1]
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  # UITableViewDelegate protocol methods

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath:indexPath)
    NSLog("Row %d was tapped", indexPath.row)
  end
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    NSLog("Row %@ was tapped", indexPath.row)
    # prepare the new vc
    ppvc = PlacePhotosViewController.alloc.init
    ppvc.place = self.top_places[indexPath.row]
    self.navigationController.pushViewController(ppvc, animated:true)
    # push it onto the stack
  end
end
