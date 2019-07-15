//
//  ShowImageViewController.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/13/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    func setup(_ url: String) {
        print("url:\(url)")
        
        let image = UIImageView()
        image.loadURL(at: url)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.addSubview(image)
        
        let buttonClose = UIButton()
        buttonClose.backgroundColor = .black
        buttonClose.setTitle("Cerrar", for: .normal)
        buttonClose.tintColor = .white
        
        buttonClose.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        self.view.addSubview(buttonClose)
        
        view.addContraintsWithFormat(format: "H:|-0-[v0]-0-|", views: buttonClose)
        view.addContraintsWithFormat(format: "H:|-0-[v0]-0-|", views: image)
        view.addContraintsWithFormat(format: "V:|-0-[v0]-0-[v1(80)]-0-|", views: image, buttonClose)
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }
}
