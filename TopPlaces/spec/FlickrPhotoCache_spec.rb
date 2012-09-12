describe "FlickrPhotoCache" do
  before do
    @fpc = FlickrPhotoCache.new
  end

  it "builds a file manager" do
    @fpc.file_manager.should.satisfy { |obj|
      obj.kind_of? NSFileManager
    }
  end
  
end