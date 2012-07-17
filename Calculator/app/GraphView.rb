class GraphView < UIView
  def drawRect(rect)
    point = CGPoint.new
    point.x = bounds.origin.x + (bounds.size.width / 2)
    point.y = bounds.origin.y + (bounds.size.height / 2)
    # drawAxesInRect:originAtPoint:scale:
    AxesDrawer.drawAxesInRect(rect, originAtPoint:point, scale:10.0)
  end
end
