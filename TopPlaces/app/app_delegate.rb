class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      storyboard = UIStoryboard.storyboardWithName "iPad-Storyboard", bundle: NSBundle.mainBundle
    else
      storyboard = UIStoryboard.storyboardWithName "iPhone-Storyboard", bundle: NSBundle.mainBundle
    end
    view_controller = storyboard.instantiateViewControllerWithIdentifier("Main")

    NSLog("AppDelegate#application: setting root VS to #{view_controller}")

    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @window.rootViewController = view_controller
    @window.makeKeyAndVisible
    true 
  end
end
