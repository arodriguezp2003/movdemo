//
//  Extensions.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.
//  Copyright © 2019 Tech. All rights reserved.
//
import UIKit
import Alamofire
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
    
    func loadURL(at url:String) {
        if let url = URL(string: url) {
            image = nil
            
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
                DispatchQueue.main.async {
                     self.image = imageFromCache
                }
               
                return
            }
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageCache.setObject(image, forKey: url as AnyObject)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
