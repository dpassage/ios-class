class RecentPhotosViewController < PhotoListViewController

  def photos
    FlickrPhoto.get_photo_history
  end

  def viewDidLoad
    self.title = "Recents"
  end

  def viewWillAppear(animated)
    super
    self.tableView.reloadData
  end

end
