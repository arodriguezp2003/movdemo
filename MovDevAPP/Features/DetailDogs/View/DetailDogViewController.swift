//
//  DetailDogViewController.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.

import UIKit
protocol DetailDogDisplayLogic: class {
    func getDogList(_ images: [DogImageEntity])
    func errorData(_ message: String)
}

class DetailDogViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout , DetailDogDisplayLogic {
 
    
	var presenter: DetailDogPresentationLogic?
    var images: [DogImageEntity] = []
    
    
    private let CELL = "cell"
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 20.0,
                                             bottom: 10.0,
                                             right: 20.0)
    
	// MARK: Object lifecycle
	override public func viewDidLoad() {
		super.viewDidLoad()
        collectionView?.contentInsetAdjustmentBehavior = .never
        self.presenter?.getImageList()
        self.setup()
	}
    
    func setup() {
        self.view.backgroundColor = .white
        self.collectionView.backgroundColor = .white
        navigationItem.title = presenter?.dataStore?.dog.name
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.scrollDirection = .vertical
        }
       
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: CELL)
 
    }
    
    func getDogList(_ images: [DogImageEntity]) {
        DispatchQueue.main.async {
            self.images = images
            self.collectionView.reloadData()
        }
    }
    func errorData(_ message: String) {
        let vc = AlertRetryFactory().getAlertRetryViewController(title: "Ups :(", subtitle: message)
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
  
}
// MARK: CollectionView
extension DetailDogViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL, for: indexPath) as? ImageCell
        cell!.setup(obj: self.images[indexPath.item])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.images[indexPath.item]
        let vc = ShowImageViewController()
        vc.setup(obj.image)
        self.present(vc, animated: true)
    }
}
extension DetailDogViewController: AlertRetryDelegate {
    func retry() {
        self.presenter?.getImageList()
    }
}
