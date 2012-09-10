class PlacePhotosViewController < PhotoListViewController

  def place=(place)
    @place = place
  end

  def place
    @place
  end

  def photos
    @photos ||= FlickrFetcher.photosInPlace(self.place, maxResults:50).map { |p| FlickrPhoto.new(p) }
  end

  def viewDidLoad
    self.title = self.place["_content"].split(",", 2)[0]
  end

end
