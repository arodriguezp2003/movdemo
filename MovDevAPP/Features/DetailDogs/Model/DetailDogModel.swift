//
//  DetailDogModel.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import UIKit

protocol DetailDogModelLogic {
    var delegate: DogImageModelDelegate? { get set }
    func getImageList()
}

protocol DogImageModelDelegate {
    func updateData() -> Void
    func errorData(_ message: String) -> Void
}
protocol DetailDogDataStore {
	var dog: DogEntity { get set }
    var images: [DogImageEntity]? { get set }
   
}

class DetailDogModel: DetailDogModelLogic, DetailDogDataStore {    
    var service: DetailDogService?
    var delegate: DogImageModelDelegate?
    var dog: DogEntity
    var images: [DogImageEntity]?
    
    init(_ dog: DogEntity) {
        self.dog = dog
    }

    func getImageList()  {
        self.service?.getImageList(filter: self.dog.name, completion: { (success, list, message)  in
            if success {
                self.images = list
                self.delegate?.updateData()
            } else {
                self.delegate?.errorData(message)
            }
        })
    }
}
