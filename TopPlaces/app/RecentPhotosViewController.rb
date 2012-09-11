class RecentPhotosViewController < ItemListViewController

  def items
    FlickrPhoto.get_photo_history
  end

  def cell_name
    "Photo Cell"
  end

  def viewDidLoad
    self.title = "Recents"
  end

  def viewWillAppear(animated)
    super
    self.tableView.reloadData
  end

end
