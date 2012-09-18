class ItemListViewController < UITableViewController

  extend IB

  def refresh(sender)
    @button = self.navigationItem.rightBarButtonItem
    NSLog("@button is %@", @button)
    NSLog("%@ sent refresh", sender)
    spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    NSLog("start animating")
    spinner.startAnimating
    NSLog("set rightBarButtonItem")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(spinner)
    NSLog("reload items")
    self.reload_items
  end

  def refresh_done
    self.navigationItem.rightBarButtonItem = @button
  end

  def prepareForSegue(segue, sender: sender)
    indexPath = self.tableView.indexPathForCell sender
    segue.destinationViewController.item = self.items[indexPath.row]
  end

  def viewWillAppear(animated)
    super
 
    if self.items.length == 0
      refresh(nil)
    end
  end

  # UITableViewDataSource protocol methods

  def tableView(view, numberOfRowsInSection:section)
    self.items.size
  end

  def tableView(view, cellForRowAtIndexPath:indexPath)
    NSLog("In tableView:cellForRowAtIndexPath %@", indexPath)
    cell = self.tableView.dequeueReusableCellWithIdentifier(self.cell_name)
    if (!cell) 
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                 reuseIdentifier:self.cell_name)
    end    
    item = self.items[indexPath.row]
    cell.textLabel.text = item.title
    cell.detailTextLabel.text = item.description
    cell
  end

end
