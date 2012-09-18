class PhotoMapViewController < UIViewController

  extend IB

  outlet :map, MKMapView

  def items
    @items ||= []
  end

  def items=(items)
    if (@items != items)
      @items = items
    end
  end

  def viewDidLoad
    self.map.delegate = self
    NSLog("PhotoMapViewController#viewDidLoad: items is #{self.items}")

    min_lat, max_lat = @items.map { |i| i.latitude }.minmax
    min_long, max_long = @items.map { |i| i.longitude }.minmax

    region = MKCoordinateRegion.new (CLLocationCoordinate2D.new((min_lat + max_lat) / 2, (min_long + max_long) / 2),
                                     MKCoordinateSpan.new((min_lat - max_lat).abs, (min_long - max_long).abs ) )

    NSLog("PhotoMapViewController#viewDidLoad: region is #{region}")

    self.map.region = region

    annotations = @items.map do |item|
      annotation = MKPointAnnotation.alloc.init
      annotation.coordinate = [item.latitude, item.longitude]
      annotation
    end

    self.map.addAnnotations(annotations)

  end

  # MKMapViewDelegate methods
  def mapView(theMapView, viewForAnnotation:annotation)
    pinView = theMapView.dequeueReusableAnnotationViewWithIdentifier("PhotoPin")
    if (!pinView)
       pinView = MKPinAnnotationView.alloc.initWithAnnotation(annotation,
                                                    reuseIdentifier:"PhotoPin")
       pinView.animatesDrop = true
    else
      pinView.annotation = annotation;
    end
    pinView
  end
  
end