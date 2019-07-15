//
//  ImageCell.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView = {
        let image =  UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    func setupViews() {
        addSubview(self.imageView)
        self.addContraintsWithFormat(format: "H:|[v0]|", views: self.imageView)
        self.addContraintsWithFormat(format: "V:|[v0]|", views: self.imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = UIImage()
    }
    
}
