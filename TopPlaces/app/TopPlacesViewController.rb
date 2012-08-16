class TopPlacesViewController < UITableViewController
  def init
    @cell_titles = ["foo", "bar", "baz"]
    @cell_subtitles = ["ack", "pfft!", "whee"]
    initWithStyle UITableViewStylePlain

  end

  # UITableViewDataSource protocol methods

  def numberOfSectionsInTableView(view)
    1
  end

  def tableView(view, numberOfRowsInSection:section)
    @cell_titles.size
  end

  def tableView(view, cellForRowAtIndexPath:indexPath)
    NSLog("In tableView:cellForRowAtIndexPath %@", indexPath)
    cell = self.tableView.dequeueReusableCellWithIdentifier("Top Place Cell")
    if (!cell) 
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                 reuseIdentifier:"Top Place Cell")
    end    
    cell.textLabel.text = @cell_titles[indexPath.row]
    cell.detailTextLabel.text = @cell_subtitles[indexPath.row]
    cell
  end
end
