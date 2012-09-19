class FlickrPlace

  def initialize(place_dict)
    @place_dict = place_dict
  end

  def title
    @place_dict["_content"].split(", ", 2)[0]
  end

  def description
    @place_dict["_content"].split(", ", 2)[1]
  end

  def latitude
    @place_dict["latitude"].to_f
  end

  def longitude
    @place_dict["longitude"].to_f
  end

  # MKAnnotation methods

  def coordinate
    @coordinate ||= CLLocationCoordinate2D.new(self.latitude, self.longitude)
  end


  def photos(limit)
    FlickrFetcher.photosInPlace(@place_dict, maxResults:limit).map { |p| FlickrPhoto.new(p) }
  end

  def self.top_places
    FlickrFetcher.topPlaces.map { |p| FlickrPlace.new(p) }.sort { |a,b| a.title <=> b.title }
  end
end