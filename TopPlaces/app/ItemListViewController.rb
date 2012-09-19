class ItemListViewController < UITableViewController

  extend IB

  def refresh(sender)
    NSLog("@button is %@", @button)
    NSLog("%@ sent refresh", sender)
    spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    NSLog("start animating")
    spinner.startAnimating
    NSLog("set titleView")
    self.navigationItem.titleView = spinner
    NSLog("reload items")
    self.reload_items
  end

  def refresh_done
    self.navigationItem.titleView = nil
  end

  def map(sender)
    NSLog("#{self}#map called with sender #{sender}")
  end

  def prepareForSegue(segue, sender: sender)
    if sender.is_a?(UITableViewCell)
      indexPath = self.tableView.indexPathForCell sender
      segue.destinationViewController.item = self.items[indexPath.row]
    elsif segue.identifier == "Map"
      segue.destinationViewController.items = self.items
    end
  end

  def viewWillAppear(animated)
    super
    NSLog("ItemListViewController#viewWillAppear: self.items.size is #{self.items.size}")
    if self.items.size == 0
      refresh(nil)
    end
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end

  # UITableViewDataSource protocol methods

  def tableView(view, numberOfRowsInSection:section)
    self.items.size
  end

  def tableView(view, cellForRowAtIndexPath:indexPath)
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
