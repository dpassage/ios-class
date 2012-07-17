class GraphView < UIView
  attr_accessor :data_source
  SCALE = 10.0
  def drawRect(rect)
    middle = CGPoint.new
    middle.x = bounds.origin.x + (bounds.size.width / 2)
    middle.y = bounds.origin.y + (bounds.size.height / 2)
    # drawAxesInRect:originAtmiddle:scale:
    AxesDrawer.drawAxesInRect(bounds, originAtPoint:middle, scale:SCALE)

    context = UIGraphicsGetCurrentContext()

    CGContextBeginPath(context)

    x_coord = bounds.origin.x
    x_value = (x_coord - middle.x) / SCALE
    y_value = data_source.y_value_for_x(x_value)
    y_coord = middle.y - (SCALE * y_value)
    CGContextMoveToPoint(context, x_coord, y_coord)

    x_coord += 1
    while x_coord < bounds.origin.x + bounds.size.width
      x_value = (x_coord - middle.x) / SCALE
      y_value = data_source.y_value_for_x(x_value)
      y_coord = middle.y - (SCALE * y_value)
      CGContextAddLineToPoint(context, x_coord, y_coord)
      x_coord += 1
    end
    CGContextStrokePath(context)

  end
end
