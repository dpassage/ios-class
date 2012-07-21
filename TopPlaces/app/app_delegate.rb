class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    tab_controller = UITabBarController.alloc.init
    view_controller = TopPlacesViewController.alloc.init
    other_view_controller = TopPhotosViewController.alloc.init

    tab_controller.viewControllers = [view_controller, other_view_controller]
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible


  end
end
