class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    storyboard = UIStoryboard.storyboardWithName("MainStoryboard", bundle: NSBundle.mainBundle)
    view_controller = storyboard.instantiateViewControllerWithIdentifier("Main")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = view_controller
    @window.makeKeyAndVisible

    true  
  end
end
