//
//  MainTableViewManager.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol MainViewManagerDelegate: class {
    func didSelect(place: Place)
}

protocol MainTableViewInput {
    func setup(tableView: UITableView)
    func reloadData()
}

final class MainTableViewManager: NSObject {
    
    weak var tableView: UITableView?
    weak var delegate: MainViewManagerDelegate?
    private let cellID = "cell"
}

// MARK: - MainTableViewInput
extension MainTableViewManager: MainTableViewInput {
    
    func setup(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellID)
        
        self.tableView = tableView
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let placeCell = cell as? MainTableViewCell else { return cell }
        let place = CoreDataManager.shared.places[indexPath.row]
        guard let photoData = place.photo,
            let photo = UIImage(data: photoData as Data),
            let name = place.name,
            let placeDescription = place.placeDescription else { return cell }
        
        placeCell.setup(name: name, placeDescription: placeDescription, photo: photo)
        
        return placeCell
    }
}

// MARK: - UITableViewDelegate
extension MainTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let place = CoreDataManager.shared.places[indexPath.row]
        delegate?.didSelect(place: place)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let place = CoreDataManager.shared.places[indexPath.row]
        CoreDataManager.shared.deletePlace(place: place)
        CoreDataManager.shared.places.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
