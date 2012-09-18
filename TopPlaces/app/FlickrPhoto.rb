class FlickrPhoto

  def initialize(photo_dict)
    @photo_dict = photo_dict
  end

  def id
    @photo_dict["id"]
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
    NSLog("FlickrPhoto#image: looking on disk")

    cache_data = FlickrPhotoCache.cache[self.id]
    if cache_data
      return UIImage.imageWithData(cache_data)
    end

    NSLog("FlickrPhoto#image: loading from URL")

    url = FlickrFetcher.urlForPhoto(@photo_dict, format:FlickrPhotoFormatLarge)
    data = NSData.dataWithContentsOfURL(url)
    FlickrPhotoCache.cache[self.id] = data
    return UIImage.imageWithData(data)
  end

  def save_to_history
    history = NSUserDefaults.standardUserDefaults.arrayForKey("photo_history")
    if history == nil
      history = []
    else
      history = history.dup
    end
    history.delete_if {|photo| photo["id"] == @photo_dict["id"] }
    history.unshift(@photo_dict)
    history = history[0, 20]
    NSUserDefaults.standardUserDefaults.setObject(history, forKey:"photo_history")
  end

  def self.get_photo_history
    history = NSUserDefaults.standardUserDefaults.arrayForKey("photo_history")
    history.map { |e| FlickrPhoto.new(e) }
  end
end
