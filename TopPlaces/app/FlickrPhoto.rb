class FlickrPhoto

  def initialize(photo_dict)
    @photo_dict = photo_dict
    NSLog("New photo dict #{photo_dict}")
  end

  # Sample photo_dict from Flickr
  # {"place_id"=>"xfcEFYhWULKtjYI", 
  #   "accuracy"=>"16", 
  #   "farm"=>9, 
  #   "isfriend"=>0, 
  #   "originalsecret"=>"9e51989f2e", 
  #   "secret"=>"b77e2dcf68", 
  #   "latitude"=>52.3585205078125, 
  #   "context"=>0, "isfamily"=>0, "geo_is_family"=>0, "id"=>"8000628377", 
  #   "ispublic"=>1, "longitude"=>4.89108467102051, "geo_is_friend"=>0, 
  #   "geo_is_public"=>1, "ownername"=>"Rubia Michels", 
  #   "owner"=>"78285750@N04", "server"=>"8036", "title"=>"", 
  #   "originalformat"=>"jpg", "woeid"=>"728410", "geo_is_contact"=>0, 
  #   "dateupload"=>"1347996754", 
  #   "description"=>{"_content"=>"                               "}, 
  #   "tags"=>""}

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

  def subtitle
    description
  end

  def latitude
    @photo_dict["latitude"]
  end

  def longitude
    @photo_dict["longitude"]
  end

  def image
    grab_image("main", FlickrPhotoFormatLarge)
  end

  def thumbnail
    grab_image("thumb", FlickrPhotoFormatSquare)
  end

  def grab_image(type, format)
    NSLog("FlickrPhoto#image: looking on disk")

    cache_data = FlickrPhotoCache.cache[self.id + type]
    if cache_data
      return UIImage.imageWithData(cache_data)
    end

    NSLog("FlickrPhoto#image: loading from URL")

    url = FlickrFetcher.urlForPhoto(@photo_dict, format:format)
    data = NSData.dataWithContentsOfURL(url)
    FlickrPhotoCache.cache[self.id+type] = data
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

  # MKAnnotation methods

  def coordinate
    @coordinate ||= CLLocationCoordinate2D.new(self.latitude, self.longitude)
  end

  def self.get_photo_history
    history = NSUserDefaults.standardUserDefaults.arrayForKey("photo_history")
    history.map { |e| FlickrPhoto.new(e) }
  end
end
