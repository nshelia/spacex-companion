//
//  CountDownViewController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 07.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import UIKit

class LaunchViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    
    super.init(frame: .zero)
    
    setupView()
  }
  
  
  @objc func checkAction(sender : UITapGestureRecognizer) {
		
    guard let view = self.contentView.viewWithTag(200)  else {
      return
    }
    switch sender.state {
      case .began:
        UIView.animate(withDuration: 0.3, animations: {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }, completion: nil)
      case .ended:
        UIView.animate(withDuration: 0.3, animations: {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
      default:
        break
      
    }
    
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  func setupView() {
    
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 20
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowOffset = .zero
    view.layer.shadowRadius = 10
    view.layer.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
    
//    let gesture = UILongPressGestureRecognizer(target: self, action:  #selector(self.checkAction))
//    gesture.minimumPressDuration = 0
//		gesture.cancelsTouchesInView = false
//
//    view.addGestureRecognizer(gesture)


    self.contentView.addSubview(view)

		
    

    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
    ])
    
    let mainImage = UIImageView()
    do {
      let url = URL(string: "https://www.teslarati.com/wp-content/uploads/2019/10/Starship-2019-Mars-base-render-SpaceX-1-full-crop-c.jpg")
         
           let data = try Data(contentsOf: url!)
      mainImage.image = UIImage(data: data)
			mainImage.contentMode = .scaleAspectFill
    } catch {
      print("\(error)")
    }
    view.addSubview(mainImage)
    
    mainImage.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        mainImage.topAnchor.constraint(equalTo: view.topAnchor),
        mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    
    view.clipsToBounds = true
    
    let bgOverlay = UIView()
    
    bgOverlay.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bgOverlay)
    
    bgOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    NSLayoutConstraint.activate([
        bgOverlay.topAnchor.constraint(equalTo: mainImage.topAnchor),
        bgOverlay.bottomAnchor.constraint(equalTo: mainImage.bottomAnchor),
        bgOverlay.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
        bgOverlay.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor),
    ])
    bgOverlay.tag = 200
		
    let label = UILabel(frame: .zero)
    label.font = UIFont.preferredFont(forTextStyle: .title3).withSize(24)

    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.textAlignment = .center
    label.text = ""
    label.tag = 100
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
    
    label.translatesAutoresizingMaskIntoConstraints = false
		
    view.addSubview(label)
		NSLayoutConstraint.activate([
		 label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		 label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
	 ])
	 
	 NSLayoutConstraint.activate([
		 label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
		 label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5)
	 ])
		
		let backBtn = UIButton(type: .close)
		
    backBtn.translatesAutoresizingMaskIntoConstraints = false
		backBtn.tag = 9
		backBtn.backgroundColor = .green
		
		view.addSubview(backBtn)
		
		NSLayoutConstraint.activate([
		 backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
		 backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:  30)
		])
   

  }

}
