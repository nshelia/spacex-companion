//
//  LaunchesViewModel.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 07.03.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import Foundation


protocol LaunchesViewModelViewDelegate: class {
  func insertNewItem(_ viewModel: LaunchesViewModel, indexPath: IndexPath)
}

protocol LaunchesViewModelData {
  var viewDelegate: LaunchesViewModelViewDelegate? { get set }
  
	func fetchItems()
}

class LaunchesViewModel: LaunchesViewModelData {
  var api = SpaceXAPI()
  var headerNames = ["Next Launch", "Recent launches"]
  var missionNames = [Int:Array<String>]()
  
  weak var viewDelegate: LaunchesViewModelViewDelegate?

	func fetchItems() {
		print("LaunchesViewModel: fetchItems")

		api.getNextLaunch(onFinish: { (data: NextLaunch) in
			DispatchQueue.main.async {
				var arr = [String]()
				arr.append(data.mission_name)
				self.missionNames[0] = arr
				self.viewDelegate?.insertNewItem(self, indexPath: IndexPath(row: 0,section: 0))
			}
		})
    
    api.getRecentLaunches(limit: 2, onFinish: { (data: Array<Launch>) in
			DispatchQueue.main.async {
				var arr = [String]()
				for item in data {
					arr.append(item.mission_name)
				}
				self.missionNames[1] = arr
				for (index,_) in data.enumerated() {
					self.viewDelegate?.insertNewItem(self, indexPath: IndexPath(row: index,section: 1))
				}
			}
    })

  }
  
}
