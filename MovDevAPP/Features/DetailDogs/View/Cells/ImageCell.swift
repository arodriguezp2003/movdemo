//
//  ImageCell.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.af_cancelImageRequest()
        self.imageView.image = nil
    }
    
    var imageView: UIImageView = {
        let image =  UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFit
        return image
    }()
    
    func setup(obj: DogImageEntity) {
        setupImage(obj.image)
        setupViews()
    }
    
    func setupImage(_ url: String ) {
        DispatchQueue.main.async {
            self.imageView.cacheImage(urlString: url)
        }
    }
    
    func setupViews() {
        addSubview(self.imageView)
        self.addContraintsWithFormat(format: "H:|[v0]|", views: self.imageView)
        self.addContraintsWithFormat(format: "V:|[v0]|", views: self.imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.af_cancelImageRequest()
        self.imageView.image = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
