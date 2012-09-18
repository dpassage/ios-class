describe "FlickrPhotoCache" do
  before do
    @fpc = FlickrPhotoCache.new
  end

  it "builds a file manager" do
    @fpc.file_manager.should.be.kind_of?(NSFileManager)
  end
  
  it "returns a cache directory that is a directory" do
    @fpc.cache_directory.
      resourceValuesForKeys([NSURLIsDirectoryKey], 
                      error:nil)[NSURLIsDirectoryKey].should.be.true?
  end

  it "reads and writes a file to the cache" do
    data = "Foo".dataUsingEncoding(NSUTF8StringEncoding)
    id = "bar"
    @fpc[id] = data

    reread_data = @fpc[id]
    reread_data.should.be.kind_of(NSData)
    data_string = NSString.alloc.initWithData(reread_data, 
                                     encoding:NSUTF8StringEncoding)
    data_string.should == "Foo"
  end

  it "returns nil for a file that's not in the cache" do
    @fpc["This is not a file"].should.be.nil?
  end

  it "returns files in the directory" do
    files = @fpc.files_in_cache_directory
    files.each { |file| 
      puts "#{file.size} #{file.last_access_time}" 
      file.should.be.is_a?(FlickrPhotoCache::CacheFile)
    }

  end

  # it "removes the oldest file when the total cache size reaches the limit" do
  #   # set the limit to 10x4096
  #   @fpc.cache_size = 40960
  #   data = "Foo".dataUsingEncoding(NSUTF8StringEncoding)
  #   (1..10).each do |n|
  #     @fpc[n.to_s] = data
  #   end
  #   # cache it 10 times
  #   # see if the first one is still in the cache
  #   @fpc["1"].should.be.nil?
  #   # 
  # end

  describe "FlickrPhotoCache::CacheFile" do
    before do
      @cachefileurl = 
        @fpc.cache_directory.URLByAppendingPathComponent("test_file")
      "Foobar!".writeToURL(@cachefileurl, 
                atomically:true, 
                  encoding:NSUTF8StringEncoding, 
                     error:nil)
      @cachefile = FlickrPhotoCache::CacheFile.new(@cachefileurl)
    end
    it "returns the file size" do
      @cachefile.size.should == 4096
    end
    it "returns the last access time" do
      @cachefile.last_access_time.should.be.kind_of?(NSDate)
      puts @cachefile.last_access_time
    end
    it "returns the nsurl object for the file" do
      @cachefile.url.should == @cachefileurl
    end
  end
end
