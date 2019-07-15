//
//  AlertRetryFactory.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.

import Foundation

@objc public class AlertRetryFactory: NSObject {
    @objc public override init() { }

    @objc public func getAlertRetryViewController(title: String="", subtitle: String="") -> AlertRetryViewController {
        let viewController = AlertRetryViewController()
        let presenter = AlertRetryPresenter()
        let model = AlertRetryModel(title: title, subtitle: subtitle)
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.dataStore = model
        presenter.model = model
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
}
