//
//  DetailRouter.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol DetailRouterInput {
    
}

final class DetailViewRouter {
    
    //MARK: - Properties
    
    unowned private let view: UIViewController
    
    //MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
}

//MARK: - DetailRouterInput
extension DetailViewRouter: DetailRouterInput {
    
}
