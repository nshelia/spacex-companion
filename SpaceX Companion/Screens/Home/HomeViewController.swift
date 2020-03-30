//
//  ViewController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 06.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, LaunchesViewModelViewDelegate {
  
  
  var viewModel: LaunchesViewModel!
	
  let cellId = "LaunchViewCell"
  let headerId = "MyHeader"
	
  weak var collectionView: UICollectionView!
  
  func insertNewItem(_ viewModel: LaunchesViewModel, indexPath: IndexPath) {
    self.collectionView?.insertItems(at: [indexPath])
  }
  
	init(viewModel: LaunchesViewModel) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
  override func loadView() {
      super.loadView()
      viewModel.viewDelegate = self

      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
      collectionView.translatesAutoresizingMaskIntoConstraints = false
    
      self.view.addSubview(collectionView)
    
      NSLayoutConstraint.activate([
          collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
          collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
          collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      ])
    
      self.collectionView = collectionView
  }

  override func viewDidLoad() {
      super.viewDidLoad()

      self.collectionView.dataSource = self
      self.collectionView.delegate = self

      self.collectionView.register(LaunchViewCell.self, forCellWithReuseIdentifier: cellId)
      self.collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
      viewModel.fetchItems()
     
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }

}

extension HomeViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.headerNames.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

			return viewModel.missionNames[section]?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LaunchViewCell
			let label = cell.viewWithTag(100) as! UILabel?
			let btn = cell.viewWithTag(9) as! UIButton?
			btn!.isHidden = true
			label!.text = viewModel.missionNames[indexPath.section]?[indexPath.row]
		
			return cell
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
		let label = header.viewWithTag(105) as! UILabel?
					 
		label!.text = viewModel.headerNames[indexPath.section]

		return header
	}

}
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
				
			let cell = collectionView.cellForItem(at: indexPath)
			cell?.superview?.bringSubviewToFront(cell!)
			let btn = cell!.viewWithTag(9) as! UIButton

			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: ({
				cell?.frame = collectionView.bounds
				collectionView.isScrollEnabled = false
				btn.isHidden = false
				btn.addTarget(self, action: #selector(self.backBtnAction), for: .touchUpInside)
			}), completion: nil)
			
			
    }
	
	@objc func backBtnAction() {
		var indexPath = collectionView.indexPathsForSelectedItems as! [IndexPath]
		collectionView.isScrollEnabled = true
		collectionView.reloadItems(at: indexPath)
	}

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      if (indexPath.row == 0 && indexPath.section == 0) {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 150)
      } else {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 100)
      }
    }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.bounds.size.width - 16, height: 45)
  }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }

}


extension UIView {
  func pinToEdges(topAnchor: NSLayoutYAxisAnchor?,rightAnchor: NSLayoutXAxisAnchor?, bottomAnchor: NSLayoutYAxisAnchor?,leftAnchor: NSLayoutXAxisAnchor?) {
    
    self.translatesAutoresizingMaskIntoConstraints = false
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
    if let rightAnchor = rightAnchor {
      self.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    if let leftAnchor = leftAnchor {
      self.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
  }
}

