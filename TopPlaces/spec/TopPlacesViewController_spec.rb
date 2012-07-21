describe "The Top Places view controller" do
  tests TopPlacesViewController
  it "has a single ui label" do
    labels = views(UILabel)
    labels.length.should == 1
    labels[0].text.should == "Top Places"
  end
end