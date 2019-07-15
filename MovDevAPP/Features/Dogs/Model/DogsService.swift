//
//  DogsService.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import UIKit
import Alamofire
protocol DogsServiceLogic: class {
    func getDogList(completion: @escaping  (_ success: Bool, _ list: [DogEntity], _ message: String )->())
}

class DogsService: DogsServiceLogic {
    let URL = "/breeds/list"
    
    func getDogList(completion: @escaping (_ success: Bool, _ list: [DogEntity], _ message: String )->()) {
 
        Alamofire.request("\(ConfigAPP.API)\(URL)").responseJSON { (response) in
            
            let result = response.result
            
            if response.response?.statusCode != 200 {
                completion(false, [], "Ocurrio un error")
                return
            }
            
            if result.isSuccess {
                if let data = result.value as? NSDictionary {
                    if let messages = data["message"] as? NSArray {
                        var _dogList:[DogEntity] = []
                        
                        messages.forEach({ (str) in
                            _dogList.append(DogEntity(name: "\(str)"))
                        })
                        
                        completion(true, _dogList,"")
                    }
                }
            }
            
            if result.isFailure {
                completion(false, [],result.error!.localizedDescription)
            }
        }.resume()
    }
}
