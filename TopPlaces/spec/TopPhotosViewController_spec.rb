describe "The Top Photos view controller" do
  tests TopPhotosViewController
  it "has a single ui label" do
    labels = views(UILabel)
    labels.length.should == 1
    labels[0].text.should == "Top Photos"
  end
end