//
//  NewPlaceViewConfigurator.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

final class NewPlaceViewConfigurator {
    
    static func configureModule() -> UIViewController {
        
        let module = NewPlaceViewController()
        let presenter = NewPlacePresenter()
        let router = NewPlaceRouter(view: module)
        
        module.presenter = presenter
        
        presenter.view = module
        presenter.router = router
        
        return module
    }
}
