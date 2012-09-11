class RecentPhotosViewController < ItemListViewController

  def items
    FlickrPhoto.get_photo_history
  end

  def cell_name
    "Photo Cell"
  end

  def reload_items
    self.tableView.reloadData
    refresh_done
  end

  def viewDidLoad
    self.title = "Recents"
  end

end
