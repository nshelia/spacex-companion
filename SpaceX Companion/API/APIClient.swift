//
//  File.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 08.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import Foundation

protocol APIClient {
  var serviceURL: String { get }
}

struct NextLaunch: Codable {
    var mission_name: String
    var launch_date_unix: Int
}

struct Launch: Codable {
    var mission_name: String
    var launch_date_unix: Int
}


class SpaceXAPI: APIClient {
  let serviceURL = "https://api.spacexdata.com/v3/"
  
  func fetchBase<T: Codable>(endpoint: String, onFinish: @escaping (_ data: T) -> Void) {
    let session = URLSession.shared
    let url = URL(string: serviceURL + endpoint)!
    let task = session.dataTask(with: url, completionHandler:  { data, response, error in
      let decoder = JSONDecoder()
      
      do {
        let launch = try decoder.decode(T.self, from: data!)
        onFinish(launch)
      } catch {
        print("Cannot decode json data \(error)")
      }
    
    })
    task.resume()
  }
  
  func getRecentLaunches(limit: Int,onFinish: @escaping (_ data: [Launch]) -> Void) {
    let endpoint = "launches/past?limit=\(limit)&order=desc"
    fetchBase(endpoint: endpoint, onFinish: onFinish)
  }
  
  func getNextLaunch(onFinish: @escaping (_ data: NextLaunch) -> Void) {
     let endpoint = "launches/next"
     fetchBase(endpoint: endpoint, onFinish: onFinish)
   }
  
}
