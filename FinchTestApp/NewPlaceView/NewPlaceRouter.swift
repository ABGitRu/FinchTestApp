//
//  NewPlaceRouter.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol NewPlaceRouterInput {
    func popView()
}

final class NewPlaceRouter {
    
    //MARK: - Properties
    
    unowned private let view: UIViewController
    
    //MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
}

//MARK: - NewPlaceRouterInput
extension NewPlaceRouter: NewPlaceRouterInput {
    func popView() {
        view.navigationController?.popViewController(animated: true)
    }
}
