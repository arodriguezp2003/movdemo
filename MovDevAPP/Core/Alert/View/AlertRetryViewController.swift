//
//  AlertRetryViewController.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.

import UIKit

protocol AlertRetryDisplayLogic: class {
    var delegate:AlertRetryDelegate? {set get}
}

protocol AlertRetryDelegate: class {
    func retry() -> Void
}

public class AlertRetryViewController: UIViewController, AlertRetryDisplayLogic {
	var presenter: AlertRetryPresentationLogic?
    var delegate: AlertRetryDelegate?

	// MARK: View lifecycle
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Ocurrio un error"
        txt.font = UIFont.boldSystemFont(ofSize: 24)
        txt.textAlignment = .center
        return txt
    }()
    
    let subtitleLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Al parecer tienes problemas con la conexion a internet"
        txt.lineBreakMode = .byWordWrapping
        txt.textAlignment = .center
        txt.numberOfLines = 0
        return txt
    }()
    
    let buttonRetry: UIButton = {
        let btn = UIButton()
        btn.setTitle("Reintentar", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func btnTap(_ sender : UIButton) {
        self.dismiss(animated: true)
        self.delegate?.retry()
    }
	
    override public func viewDidLoad() {
		super.viewDidLoad()
        self.setupData()
        self.setupDesing()
	}
    
    func setupData() {
        self.titleLabel.text = presenter?.dataStore?.title
        self.subtitleLabel.text = presenter?.dataStore?.subtitle
    }
    
    func setupDesing() {
      
        self.view.backgroundColor = UIColor(red: 255 , green: 255, blue: 255, alpha: 1)
        self.view.addSubview(self.containerView)
       
        
        self.view.addContraintsWithFormat(format: "H:|-16-[v0]-16-|", views: self.containerView)
        self.view.addContraintsWithFormat(format: "V:[v0(200)]", views: self.containerView)
        
        let xConstraint = NSLayoutConstraint(item: self.containerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: self.containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: -50)
        
        self.view.addConstraint(xConstraint)
        self.view.addConstraint(yConstraint)
        
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.subtitleLabel)
        self.containerView.addSubview(self.buttonRetry)
        self.containerView.addContraintsWithFormat(format: "H:|-8-[v0]-8-|", views: self.titleLabel)
        self.containerView.addContraintsWithFormat(format: "H:|-16-[v0]-16-|", views: self.subtitleLabel)
        self.containerView.addContraintsWithFormat(format: "V:|-40-[v0]-8-[v1(50)]", views: self.titleLabel, self.subtitleLabel)
        
        self.containerView.addContraintsWithFormat(format: "H:|-[v0]-|", views: self.buttonRetry)
        self.containerView.addContraintsWithFormat(format: "V:[v0(50)]-|", views: self.buttonRetry)
        
        
    }
}
