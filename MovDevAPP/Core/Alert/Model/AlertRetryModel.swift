//
//  AlertRetryModel.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.

import UIKit

protocol AlertRetryModelLogic {
}

protocol AlertRetryDataStore {
	var title: String { get set }
    var subtitle: String { get set }
}

class AlertRetryModel: AlertRetryModelLogic, AlertRetryDataStore {
    var title: String = "Ocurrio un problema"
    var subtitle: String = "Al parecer tienes un problema con tu conexion a internet."

    init(title: String, subtitle: String) {
        if title != "" {
            self.title = title
            self.subtitle = subtitle
        }
    }
}
