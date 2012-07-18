class CGPoint
  def +(point)
    ret = CGPoint.new
    ret.x = self.x + point.x
    ret.y = self.y + point.y
    ret
  end
end

class GraphView < UIView
  attr_accessor :data_source
  attr_accessor :graph_origin

  DEFAULT_SCALE = 10.0

  def scale
    @scale ||= DEFAULT_SCALE
  end

  def scale=(s)
    if @scale != s
      @scale = s
      setNeedsDisplay
    end
  end

  def graph_origin
    if @graph_origin
      @graph_origin
    else
      @graph_origin = CGPoint.new
      @graph_origin.x = bounds.origin.x + (bounds.size.width / 2)
      @graph_origin.y = bounds.origin.y + (bounds.size.height / 2)
      @graph_origin
    end
  end

  def graph_origin=(point)
    if @graph_origin != point
      @graph_origin = point
      setNeedsDisplay
    end
  end
 
  def pinch(gesture)
    NSLog("pinched!")
    if [UIGestureRecognizerStateChanged, 
        UIGestureRecognizerStateEnded].include? gesture.state
      NSLog("scale: #{self.scale} gesture.scale: #{gesture.scale}")
      self.scale *= gesture.scale
      gesture.scale = 1
    end
  end
  
  def pan(gesture)
    NSLog("panned!")
    if [UIGestureRecognizerStateChanged, 
        UIGestureRecognizerStateEnded].include? gesture.state
      translation = gesture.translationInView(self)
      self.graph_origin += translation
      gesture.setTranslation([0,0], inView:self)
    end
  end

  def drawRect(rect)
    # drawAxesInRect:originAtmiddle:scale:
    AxesDrawer.drawAxesInRect(bounds, originAtPoint:self.graph_origin, scale:scale)

    NSLog("@graph_origin is #{@graph_origin}")
    context = UIGraphicsGetCurrentContext()

    CGContextBeginPath(context)

    x_coord = bounds.origin.x
    x_value = (x_coord - self.graph_origin.x) / scale
    y_value = data_source.y_value_for_x(x_value)
    y_coord = self.graph_origin.y - (scale * y_value)
    CGContextMoveToPoint(context, x_coord, y_coord)

    x_coord += 1
    while x_coord < bounds.origin.x + bounds.size.width
      x_value = (x_coord - self.graph_origin.x) / scale
      y_value = data_source.y_value_for_x(x_value)
      y_coord = self.graph_origin.y - (scale * y_value)
      CGContextAddLineToPoint(context, x_coord, y_coord)
      x_coord += 1
    end
    CGContextStrokePath(context)

  end
end
