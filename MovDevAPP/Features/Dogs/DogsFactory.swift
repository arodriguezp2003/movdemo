//
//  DogsFactory.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import Foundation
import UIKit

@objc public class DogsFactory: NSObject {
    @objc public override init() { }

    @objc public func getDogsViewController() -> UIViewController {
        let viewController = DogsViewController()
        let presenter = DogsPresenter()
        let service = DogsService()
        let model = DogsModel()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.dataStore = model
        presenter.model = model
        model.service = service
        return viewController
    }
}
