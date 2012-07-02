class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    storyboard = UIStoryboard.storyboardWithName("Storyboard", bundle: NSBundle.mainBundle)
    view_controller = storyboard.instantiateViewControllerWithIdentifier("Main")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.rootViewController = view_controller
    @window.makeKeyAndVisible

    true  
  end
end
