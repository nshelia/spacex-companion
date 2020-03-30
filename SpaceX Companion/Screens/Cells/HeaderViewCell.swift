//
//  CountDownViewController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 07.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    
    super.init(frame: .zero)
    
    setupView()
  }
  

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  func setupView() {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    self.contentView.addSubview(view)
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
       view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 0),
       view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
       view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
   ])
    
    let label = UILabel(frame: .zero)
    label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(28)
    label.adjustsFontForContentSizeCategory = true

    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.textAlignment = .center
    label.tag = 105

    label.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(label)
    

  }

}
