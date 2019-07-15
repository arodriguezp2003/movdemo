//
//  DetailDogFactory.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import Foundation
import UIKit
@objc public class DetailDogFactory: NSObject {
    @objc public override init() { }

    @objc public func getDetailDogViewController(_ dog: String) -> UIViewController {
        
         let layout = UICollectionViewFlowLayout()
        
        let viewController = DetailDogViewController(collectionViewLayout: layout)
        let presenter = DetailDogPresenter()
        let service = DetailDogService()
        let model = DetailDogModel(DogEntity(name: dog))
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.dataStore = model
        presenter.model = model
        model.service = service
        return viewController
    }
}
