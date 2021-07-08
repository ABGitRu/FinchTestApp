//
//  MainViewAssemble.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

final class MainViewConfigurator {
    
    static func configureModuleNavigation() -> UINavigationController{
        
        let module = MainViewController()
        let presenter = MainViewPresenter()
        let router = MainViewRouter(view: module)
        let tableViewManager = MainTableViewManager()
        
        module.presenter = presenter
        module.tableViewManager = tableViewManager
        
        tableViewManager.delegate = presenter
        
        presenter.view = module
        presenter.router = router
        
        let navigationController = UINavigationController(rootViewController: module)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        return navigationController
    }
}
