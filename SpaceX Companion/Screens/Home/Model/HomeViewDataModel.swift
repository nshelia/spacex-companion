//
//  HomeViewDataModel.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 07.03.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import Foundation


protocol LaunchesModelSource {
  var missionNames: [Int: Array<String>]  { get set }
  func getNextLaunch(_ completionHandler: @escaping ((NextLaunch) -> Void))
  func getRecentLaunches(_ completionHandler: @escaping (([Launch]) -> Void))
}

class LaunchesModel: LaunchesModelSource {
  let api = SpaceXAPI()
  var missionNames = [Int: Array<String>]()
  
  func getNextLaunch(_ completionHandler: @escaping ((NextLaunch) -> Void)){
    api.getNextLaunch(onFinish: { (data: NextLaunch) in
      DispatchQueue.main.async {
        var arr = [String]()
        arr.append(data.mission_name)
        self.missionNames[0] = arr
        completionHandler(data)
      }
    })
  }
  
  func getRecentLaunches(_ completionHandler: @escaping (([Launch]) -> Void))
  {
    api.getRecentLaunches(limit: 3,onFinish: { (data: Array<Launch>) in
      DispatchQueue.main.async {
        var arr = [String]()
        for (_, item) in data.enumerated() {
          arr.append(item.mission_name)
        }

        self.missionNames[1] = arr
        completionHandler(data)
      }
    })
  }
}
