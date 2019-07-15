//
//  DogsModel.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import UIKit

protocol DogsModelLogic {
    var delegate: DogsModelDelegate? {get set}
    func getDogList()
    
}

protocol DogsDataStore {
	var dogs: [DogEntity] { get set }
}

protocol DogsModelDelegate {
    func updateData() -> Void
    func errorData (_ message: String) -> Void
}

class DogsModel: DogsModelLogic, DogsDataStore {
	var service: DogsService?
    var dogs: [DogEntity] = []
    var delegate: DogsModelDelegate?
    
    
    func getDogList()  {
        self.service?.getDogList(completion: { (success, list, message)  in
            if success {
                self.dogs = list
                self.delegate?.updateData()
            } else {
                self.delegate?.errorData(message)
            }
            
        })
    }
    
}
