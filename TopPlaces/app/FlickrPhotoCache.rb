class FlickrPhotoCache

  class CacheFile
    def initialize(ns_url_for_file)
      @ns_url = ns_url_for_file
    end
    def last_access_time
      @ns_url.resourceValuesForKeys([NSURLContentAccessDateKey], 
                              error:nil)[NSURLContentAccessDateKey]
    end
    def size
      @ns_url.resourceValuesForKeys([NSURLFileAllocatedSizeKey], 
                              error:nil)[NSURLFileAllocatedSizeKey]
    end
    def url
      @ns_url
    end
  end

  @@instance = FlickrPhotoCache.new

	def self.cache
    @@instance
  end

  def cache_size
    @cache_size ||= 10 * 1024 * 1024
  end

  def cache_size=(size)
    @cache_size = size
  end

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

  def files_in_cache_directory_by_date
    files = self.file_manager.contentsOfDirectoryAtURL(self.cache_directory,
                    includingPropertiesForKeys:[NSURLContentAccessDateKey,
                                                NSURLFileAllocatedSizeKey],
                                       options:0,
                                         error:nil).map { |url|
      FlickrPhotoCache::CacheFile.new(url)
    }
    files.sort_by { |a| a.last_access_time }
  end

  def total_cache_size
    files_in_cache_directory_by_date.inject(0) { |sum, file| sum + file.size }
  end

  def [](id)
    file_url = self.cache_directory.URLByAppendingPathComponent(id)
    data = NSData.dataWithContentsOfURL(file_url)  
    NSLog("FlickrPhotoCache#[#{id}] returning data #{data}")
    data
  end

  def []=(id, data)
    while self.total_cache_size + data.length > self.cache_size
      url_to_remove = self.files_in_cache_directory_by_date[0].url
      self.file_manager.removeItemAtURL(url_to_remove, error:nil)
    end

    file_url = self.cache_directory.URLByAppendingPathComponent(id)

    data.writeToURL(file_url, atomically: true)
  end

end