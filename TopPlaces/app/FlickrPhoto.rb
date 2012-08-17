class FlickrPhoto

  def initialize(photo_dict)
    @photo_dict = photo_dict
    NSLog("FlickrPhoto %@", photo_dict)
  end

  def title
    if @photo_dict["title"] == ""
      if description == ""
        "Unknown"
      else
        description
      end
    else
      @photo_dict["title"]
    end
  end

  def description
    @photo_dict["description"]["_content"]
  end

  def image
    return @image if @image

    url = FlickrFetcher.urlForPhoto(@photo_dict, format:FlickrPhotoFormatLarge)
    data = NSData.dataWithContentsOfURL(url)
    @image = UIImage.imageWithData(data)
  end
end
