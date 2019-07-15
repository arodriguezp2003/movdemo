//
//  Extensions.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.
//  Copyright © 2019 Tech. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireImage
extension UIView {
    func addContraintsWithFormat(format: String, views: UIView...) {
        var viewDictionaty = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionaty[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionaty))
    }
    
}

fileprivate let imageCache = NSCache<AnyObject,AnyObject>()
fileprivate let _size = CGSize(width: 150, height: 150)
extension UIImageView {
    
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        Alamofire.request(url!).responseImage { (response) in
            if let _image = response.result.value {
                DispatchQueue.main.async {
                    imageCache.setObject(_image, forKey: urlString as AnyObject)
                    self.image = _image
                }
            }

        }.resume()
    }
    

}
