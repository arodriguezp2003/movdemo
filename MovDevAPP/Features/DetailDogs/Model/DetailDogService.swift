//
//  DetailDogService.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.

import UIKit
import Alamofire
protocol DetailDogServiceLogic: class {
}

class DetailDogService: DetailDogServiceLogic {
 
    func URL(At filter:String) -> String {
        return "/breed/\(filter)/images"
    }
    func getImageList(filter: String , completion: @escaping (_ success: Bool, _ list: [DogImageEntity], _ message: String)->()) {
        let url = "\(ConfigAPP.API)\(URL(At: filter))"
        
        Alamofire.request(url).responseJSON { (response) in
    
            let result = response.result
            
            if response.response?.statusCode != 200 {
                completion(false, [], "Ocurrio un error")
                return
            }
            
            if result.isSuccess {
                if let data = result.value as? NSDictionary {
                    if let messages = data["message"] as? NSArray {
                        var _dogList:[DogImageEntity] = []
                        
                        messages.forEach({ (str) in
                            _dogList.append(DogImageEntity(image:"\(str)"))
                        })
                        
                        completion(true, _dogList, "")
                    }
                }
            }
            if result.isFailure {
                completion(false, [], result.error!.localizedDescription)
            }
            }.resume()
    }
}
