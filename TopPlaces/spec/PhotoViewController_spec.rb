describe "PhotoViewController" do 

  it "doesn't crash when photo is set before views are created" do
    storyboard = UIStoryboard.storyboardWithName('iPhone-Storyboard', bundle:nil)
    pvc = storyboard.instantiateViewControllerWithIdentifier('PhotoViewController')
    pvc.photo = FlickrPhoto.new({})
    pvc.photo.should.be.kind_of?(FlickrPhoto)
  end  

  tests PhotoViewController, id: 'PhotoViewController', storyboard: 'iPhone-Storyboard'

  it "has one scroll view" do
    views(UIScrollView).size.should == 1
  end

  it "has no image subview if photo is nil" do
    controller.item = nil
    scroll_view = views(UIScrollView)[0]
    puts scroll_view.subviews
    scroll_view.subviews.size.should == 0
  end
  
end