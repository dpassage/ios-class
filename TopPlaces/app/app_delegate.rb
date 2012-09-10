class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    tab_controller = RotatingTabController.alloc.init
    top_places_vc = TopPlacesViewController.alloc.init
    top_places_vc.title = "Top Places"
    top_places_navc = UINavigationController.alloc.initWithRootViewController(top_places_vc)
    # top_places_vc.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFeatured, tag:0)

    recent_photos_vc = RecentPhotosViewController.alloc.init
    recent_photos_vc.title = "Recents"
    recent_photos_navc = UINavigationController.alloc.initWithRootViewController(recent_photos_vc)
    # top_photos_vc.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemMostRecent, tag:1)

    tab_controller.viewControllers = [top_places_navc, recent_photos_navc]
    tab_controller.selectedViewController = top_places_navc
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible


  end
end
