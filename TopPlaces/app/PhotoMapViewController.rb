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

    self.map.addAnnotations(@items)

  end

  def prepareForSegue(segue, sender:sender)
    item = sender.annotation
    segue.destinationViewController.item = item
  end

  # MKMapViewDelegate methods
  def mapView(theMapView, viewForAnnotation:annotation)
    pinView = theMapView.dequeueReusableAnnotationViewWithIdentifier("PhotoPin")
    if (!pinView)
       pinView = MKPinAnnotationView.alloc.initWithAnnotation(annotation,
                                                    reuseIdentifier:"PhotoPin")
       pinView.animatesDrop = true
       pinView.canShowCallout = true
       pinView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
    else
      pinView.annotation = annotation;
    end
    pinView
  end

  def mapView(theMapView, didSelectAnnotationView:annotation_view)
    annotation = annotation_view.annotation
    if annotation.respond_to?(:thumbnail)
      NSLog("adding thumbnail to pinview")
      queue = Dispatch::Queue.new("FlickrFetcher")
      queue.async {
        thumbnail = annotation.thumbnail
        NSLog("thumbnail is #{thumbnail}")
        Dispatch::Queue.main.async {
          thumb_view = UIImageView.alloc.initWithFrame([[0,0],[30,30]])
          thumb_view.image = thumbnail
          annotation_view.leftCalloutAccessoryView = thumb_view
        }
      }
    end
  end

  def mapView(theMapView, annotationView:annotation_view, calloutAccessoryControlTapped:control)
    NSLog("PhotoMapViewController#mapView:annotationView:calloutAccessoryControlTapped")
    performSegueWithIdentifier("PhotoMap", sender:annotation_view)
  end

end
