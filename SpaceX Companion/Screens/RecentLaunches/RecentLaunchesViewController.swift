//
//  ViewController.swift
//  SpaceX Companion
//
//  Created by Nika Shelia on 06.02.20.
//  Copyright © 2020 Nika Shelia. All rights reserved.
//

import UIKit

class RecentLaunchesViewController: UIViewController, RecentLaunchesViewModelViewDelegate {
  
  var viewModel: RecentLaunchesViewModel!
	
  let cellId = "LaunchViewCell"
  let headerId = "MyHeader"
	
  weak var collectionView: UICollectionView!
  
  func insertNewItem(_ viewModel: RecentLaunchesViewModel, indexPath: IndexPath) {
    self.collectionView?.insertItems(at: [indexPath])
  }
  
	init(viewModel: RecentLaunchesViewModel) {
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

extension RecentLaunchesViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.headerNames.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

			return viewModel.missionNames[section]?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LaunchViewCell
			let label = cell.viewWithTag(100) as! UILabel?

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
extension RecentLaunchesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
			
    }

}

extension RecentLaunchesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: collectionView.bounds.size.width - 16, height: 100)
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



