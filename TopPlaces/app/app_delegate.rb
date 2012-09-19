class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      storyboard = UIStoryboard.storyboardWithName "iPad-Storyboard", bundle: nil
    else
      storyboard = UIStoryboard.storyboardWithName "iPhone-Storyboard", bundle: nil
    end
    @window.rootViewController = storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible
    true 
  end
end
