class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    tab_controller = UITabBarController.alloc.init
    top_places_vc = TopPlacesViewController.alloc.init
    top_places_vc.title = "Top Places"
    top_places_navc = UINavigationController.alloc.initWithRootViewController(top_places_vc)
    # top_places_vc.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFeatured, tag:0)

    top_photos_vc = TopPhotosViewController.alloc.init
    top_photos_vc.title = "Top Photos"
    top_photos_navc = UINavigationController.alloc.initWithRootViewController(top_photos_vc)
    # top_photos_vc.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemMostRecent, tag:1)

    tab_controller.viewControllers = [top_places_navc, top_photos_navc]
    tab_controller.selectedViewController = top_places_navc
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible


  end
end
