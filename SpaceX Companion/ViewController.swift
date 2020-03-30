//
//  ViewController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 06.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationItem.largeTitleDisplayMode = .always
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }
  // Do any additional setup after loading the view.

}

