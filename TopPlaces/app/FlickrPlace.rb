class FlickrPlace

  def initialize(place_dict)
    @place_dict = place_dict
    NSLog("FlickrPlace %@", place_dict)
  end

  def title
    @place_dict["_content"].split(", ", 2)[0]
  end

  def description
    @place_dict["_content"].split(", ", 2)[1]
  end

  def photos(limit)
    FlickrFetcher.photosInPlace(@place_dict, maxResults:limit).map { |p| FlickrPhoto.new(p) }
  end
end