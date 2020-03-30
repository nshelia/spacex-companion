//
//  TabBarController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 19.03.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

  override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
    self.tabBar.barTintColor = #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
    self.viewControllers = [initialTabBar,launchesTabBar]
  }

  lazy public var initialTabBar: HomeViewController = {
			let viewModel = LaunchesViewModel()
			let tabBar = HomeViewController(viewModel: viewModel)

			let tabBarItem = UITabBarItem()
			tabBarItem.image = UIImage(named: "home")
			tabBarItem.title = "Home"
		
      tabBar.tabBarItem = tabBarItem
    
      return tabBar
  }()
  lazy public var launchesTabBar: RecentLaunchesViewController = {
			let viewModel = RecentLaunchesViewModel()
			let tabBar = RecentLaunchesViewController(viewModel: viewModel)
		
			let tabBarItem = UITabBarItem()
			tabBarItem.image = UIImage(named: "start-button")
			tabBarItem.title = "Launches"
		
      tabBar.tabBarItem = tabBarItem
    
      return tabBar
  }()
}
