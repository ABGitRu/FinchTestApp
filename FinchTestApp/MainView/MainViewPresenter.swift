//
//  MainViewPresenter.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

protocol MainViewInput: class {
    
}

final class MainViewPresenter {
    
    // MARK: - Properties
    
    weak var view: MainViewInput?
    var router: MainViewRouterInput?
    
}

//MARK: - MainViewControllerOutput
extension MainViewPresenter: MainViewControllerOutput {
    func tapAddButton() {
        router?.openNewPlaceView()
    }
}

//MARK: - MainViewManagerDelegate
extension MainViewPresenter: MainViewManagerDelegate {
    func didSelect(place: Place) {
        router?.openDetailView(place: place)
    }
    
    
}

