class PlacePhotosViewController < ItemListViewController

  def place=(place)
    @place = place
  end

  def place
    @place
  end

  def item=(place)
    self.place = place
  end

  def items
    @items ||= []
  end

  def items=(items)
    if (@items != items)
      @items = items
      self.tableView.reloadData if (self.tableView.window)
    end
  end

  def reload_items
    self.items = []
    queue = Dispatch::Queue.new("FlickrFetcher")
    queue.async {
      photo_array = self.place.photos(50)
      Dispatch::Queue.main.async {
        self.items = photo_array
        refresh_done
      }
    }

  end

  def cell_name
    "Photo Cell"
  end

  def viewDidLoad
    self.title = self.place.title
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    NSLog("PlacePhotosViewController#tableView:didSelectRowAtIndexPath")
    item = self.items[indexPath.row]
    if splitViewController
      splitViewController.viewControllers.lastObject.item = self.items[indexPath.row]
    end
  end

end
