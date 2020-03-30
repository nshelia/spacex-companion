//
//  CountDownViewController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 07.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import UIKit

class ListItemView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  func setupView() {
    self.layer.cornerRadius = 20
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = 10
    self.layer.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
  }

}
