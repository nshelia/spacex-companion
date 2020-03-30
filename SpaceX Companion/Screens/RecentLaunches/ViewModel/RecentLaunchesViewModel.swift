//
//  LaunchesViewModel.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 07.03.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import Foundation


protocol RecentLaunchesViewModelViewDelegate: class {
  func insertNewItem(_ viewModel: RecentLaunchesViewModel, indexPath: IndexPath)
}

protocol RecentLaunchesViewModelData {
  var viewDelegate: RecentLaunchesViewModelViewDelegate? { get set }
  
	func fetchItems()
}

class RecentLaunchesViewModel: RecentLaunchesViewModelData {
  var api = SpaceXAPI()
  var headerNames = ["Launches"]
  var missionNames = [Int:Array<String>]()
  
  weak var viewDelegate: RecentLaunchesViewModelViewDelegate?

	func fetchItems() {
		print("RecentLaunchesViewModel: fetchItems")
    
    api.getRecentLaunches(limit: 10, onFinish: { (data: Array<Launch>) in
			DispatchQueue.main.async {
				var arr = [String]()
				for item in data {
					arr.append(item.mission_name)
				}
				self.missionNames[0] = arr
				for (index,_) in data.enumerated() {
					self.viewDelegate?.insertNewItem(self, indexPath: IndexPath(row: index,section: 0))
				}
			}
    })

  }
  
}
