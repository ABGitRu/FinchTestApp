//
//  DetailViewConfigurator.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

final class DetailViewConfigurator {
    
    struct Model {
        let place: Place
    }
    
    static func configureModule(with model: Model) -> UIViewController {
        
        let module = DetailViewController()
        let presenter = DetailViewPresenter(place: model.place)
        let router = DetailViewRouter(view: module)
        
        module.presenter = presenter
        
        presenter.view = module
        presenter.router = router
        
        return module
    }
}
