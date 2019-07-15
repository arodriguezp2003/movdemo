//
//  DetailDogPresenter.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import Foundation

protocol DetailDogPresentationLogic {
	var dataStore: DetailDogDataStore? { get set }
    func getImageList()
}

class DetailDogPresenter: DetailDogPresentationLogic, DogImageModelDelegate {
   
    

	weak var view: DetailDogDisplayLogic?
    var model: DetailDogModelLogic? {
        didSet {
            self.model?.delegate = self
        }
    }
	var dataStore: DetailDogDataStore?
    
    func getImageList() {
        self.model?.getImageList()
    }
    
    func updateData() {
        self.view?.getDogList(dataStore!.images!)
    }
    
    func errorData(_ message: String) {
        self.view?.errorData(message)
    }
    
}
