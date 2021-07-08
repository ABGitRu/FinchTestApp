//
//  DetailViewPresenter.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

protocol DetailViewInput: class {
    func updateViewIfNeeded(with person: Place?)
}

final class DetailViewPresenter {
    
    // MARK: - Properties
    
    weak var view: DetailViewInput?
    var router: DetailViewRouter?
    private let place: Place?
    
    // MARK: - Init
    
    init(place: Place? = nil) {
        self.place = place
    }
}

//MARK: - DetailViewOutput
extension DetailViewPresenter: DetailViewOutput {
    func viewIsReady() {
        view?.updateViewIfNeeded(with: place)
    }
}

