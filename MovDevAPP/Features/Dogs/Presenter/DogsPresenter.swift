//
//  DogsPresenter.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import Foundation

protocol DogsPresentationLogic {
	var dataStore: DogsDataStore? { get set }
    func getDogList()
}

class DogsPresenter: DogsPresentationLogic {
	weak var view: DogsDisplayLogic?
    var model: DogsModelLogic? {
        didSet {
            model?.delegate = self
        }
    }
    var dataStore: DogsDataStore?
    
    func getDogList()  {
       self.model?.getDogList()
    }
    
}
extension DogsPresenter: DogsModelDelegate {
    func errorData(_ message: String) {
        self.view?.errorData(message)
    }
    
    func updateData() {
        self.view?.getDogList(dataStore!.dogs)
    }
}
