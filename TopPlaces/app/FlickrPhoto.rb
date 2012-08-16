class FlickrPhoto

  def initialize(photo_dict)
    @photo_dict = photo_dict
    NSLog("FlickrPhoto %@", photo_dict)
  end

  def title
    @photo_dict["title"]
  end

  def description
    @photo_dict["description"]["_content"]
  end

end
