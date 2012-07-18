class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      storyboard = UIStoryboard.storyboardWithName("iPadStoryboard", bundle: NSBundle.mainBundle)
    else
      storyboard = UIStoryboard.storyboardWithName("MainStoryboard", bundle: NSBundle.mainBundle)
    end
    view_controller = storyboard.instantiateViewControllerWithIdentifier("Main")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = view_controller
    @window.makeKeyAndVisible

    true  
  end
end
