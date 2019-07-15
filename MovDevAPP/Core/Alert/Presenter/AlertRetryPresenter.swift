//
//  AlertRetryPresenter.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.

import Foundation

protocol AlertRetryPresentationLogic {
	var dataStore: AlertRetryDataStore? { get set }
    
}

class AlertRetryPresenter: AlertRetryPresentationLogic {
	weak var view: AlertRetryDisplayLogic?
	var model: AlertRetryModelLogic?
	var dataStore: AlertRetryDataStore?
}
