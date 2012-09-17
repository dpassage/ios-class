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
    data_string = NSString.alloc.initWithData(reread_data, encoding:NSUTF8StringEncoding)
    data_string.should == "Foo"
  end

  it "returns nil for a file that's not in the cache" do
    @fpc["This is not a file"].should.be.nil?
  end

  # it "returns files in the directory" do
  #   files = @fpc.files_in_cache_directory
  #   files.each { |file| puts "#{file.resourceValuesForKeys([NSURLFileAllocatedSizeKey,NSURLContentAccessDateKey], error:nil)}" }

  #   files.should.be.nil?

  # end
end