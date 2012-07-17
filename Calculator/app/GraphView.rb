class GraphView < UIView
  attr_accessor :data_source

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

  def pinch(gesture)
    NSLog("pinched!")
    if [UIGestureRecognizerStateChanged, 
        UIGestureRecognizerStateEnded].include? gesture.state
      NSLog("scale: #{self.scale} gesture.scale: #{gesture.scale}")
      self.scale *= gesture.scale
      gesture.scale = 1
    end
  end
  
  def drawRect(rect)
    middle = CGPoint.new
    middle.x = bounds.origin.x + (bounds.size.width / 2)
    middle.y = bounds.origin.y + (bounds.size.height / 2)
    # drawAxesInRect:originAtmiddle:scale:
    AxesDrawer.drawAxesInRect(bounds, originAtPoint:middle, scale:scale)

    context = UIGraphicsGetCurrentContext()

    CGContextBeginPath(context)

    x_coord = bounds.origin.x
    x_value = (x_coord - middle.x) / scale
    y_value = data_source.y_value_for_x(x_value)
    y_coord = middle.y - (scale * y_value)
    CGContextMoveToPoint(context, x_coord, y_coord)

    x_coord += 1
    while x_coord < bounds.origin.x + bounds.size.width
      x_value = (x_coord - middle.x) / scale
      y_value = data_source.y_value_for_x(x_value)
      y_coord = middle.y - (scale * y_value)
      CGContextAddLineToPoint(context, x_coord, y_coord)
      x_coord += 1
    end
    CGContextStrokePath(context)

  end
end
