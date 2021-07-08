//
//  MainViewRouter.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol MainViewRouterInput: class {
    func openNewPlaceView()
    func openDetailView(place: Place)
}

final class MainViewRouter {
    
    //MARK: - Properties
    
    unowned private let view: UIViewController
    
    //MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
}

//MARK: - MainViewRouterInput
extension MainViewRouter: MainViewRouterInput {
    func openDetailView(place: Place) {
        let model = DetailViewConfigurator.Model(place: place)
        let module = DetailViewConfigurator.configureModule(with: model)
        view.navigationController?.pushViewController(module, animated: true)
    }
    
    func openNewPlaceView() {
        let viewNext = NewPlaceViewConfigurator.configureModule()
        view.navigationController?.pushViewController(viewNext, animated: true)
    }
}

