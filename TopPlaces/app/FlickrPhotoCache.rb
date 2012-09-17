class FlickrPhotoCache

 #  class CacheFile
 #    def initialize(ns_url_for_file)
 #      @ns_url = ns_url_for_file
 #    end
 #    def last_access_time
 #    end
 #    def size
 #    end
 #  end
	# def self.cache
 #    self.new
 #  end

  def file_manager
    @file_manager ||= NSFileManager.defaultManager
  end

  def cache_directory
    if @cache_directory
      @cache_directory
    else
      caches_dir_url = 
        self.file_manager.URLsForDirectory(NSCachesDirectory, 
                                 inDomains:NSUserDomainMask)[0]
      photo_cache_url = 
        caches_dir_url.URLByAppendingPathComponent("FlickrPhotoCache")
      self.file_manager.createDirectoryAtURL(photo_cache_url, 
                 withIntermediateDirectories:true, 
                                  attributes:nil, 
                                       error:nil)
      @cache_directory = photo_cache_url
    end
  end

  # def files_in_cache_directory
  #   files = 
  #     self.file_manager.contentsOfDirectoryAtURL(self.cache_directory,
  #                     includingPropertiesForKeys:[NSURLContentAccessDateKey,
  #                                                 NSURLFileAllocatedSizeKey],
  #                                        options:0,
  #                                          error:nil,)

  # end

  def [](id)
    file_url = self.cache_directory.URLByAppendingPathComponent(id)
    NSData.dataWithContentsOfURL(file_url)
    # look for file in directory
    # if it's not there, return nil
    # if it's there, load and return the file as NSData
  end

  def []=(id, data)
    # check size of cache
    # if not enough room for data, remove until there is

    # - (NSURL *)URLByAppendingPathComponent:(NSString *)pathComponent
    file_url = self.cache_directory.URLByAppendingPathComponent(id)

    # write data to new file using id as its name

    #- (BOOL)writeToURL:(NSURL *)aURL atomically:(BOOL)atomically
    data.writeToURL(file_url, atomically: true)
    # returns true on success
  end

end