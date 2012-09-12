class FlickrPhotoCache

	def self.cache
    self.new
  end

  def file_manager
    @file_manager ||= NSFileManager.defaultManager
  end

  def cache_directory
    @cache_directory ||= self.file_manager.URLsForDirectory(caches, inDomains: domain)
  end

  def [](id)
    # look for file in directory
    # if it's not there, return nil
    # if it's there, load and return the file as NSData
  end

  def []=(id, data)
    # check size of cache
    # if not enough room for data, remove until there is
    # write data to new file using id as its name
  end

end