//
//  NewPlacePresenter.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol NewPlaceViewInput: class {
    
}

final class NewPlacePresenter {
    
    // MARK: - Properties
    
    weak var view: NewPlaceViewInput?
    var router: NewPlaceRouter?
    private var coreData = CoreDataManager.shared
    
}

//MARK: - NewPlaceViewOutput
extension NewPlacePresenter: NewPlaceViewOutput {
    func didTapdAddPlace(name: String, placeDescription: String, photo: UIImage) {
        coreData.addPlace(name: name, placeDescription: placeDescription, photo: photo)
        router?.popView()
    }
}
