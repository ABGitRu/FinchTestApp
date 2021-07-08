//
//  CoreDataManager.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    var places: [Place] = []
    
    private let coreDataStack = CoreDataStack.shared
    
    func addPlace(name: String, placeDescription: String, photo: UIImage) {
        let context = coreDataStack.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(
                forEntityName: "Place",
                in: context
        ),
        let placesObj = NSManagedObject(
            entity: entity,
            insertInto: context
        ) as? Place else { return }
        
        placesObj.name = name
        placesObj.placeDescription = placeDescription
        let data = photo.pngData() as Data?
        placesObj.photo = data
        do {
            try context.save()
            places.append(placesObj)
        } catch let createError as NSError {
            print("Failed to create: \(createError), \(createError.userInfo)")
        }
    }
    
    func fetchPlace() {
        let context = coreDataStack.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        
        do {
            places = try context.fetch(fetchRequest)
        } catch let fetchError as NSError {
            print("Failed to fetch: \(fetchError), \(fetchError.userInfo)")
        }
    }
    
    func deletePlace(place: Place) {
        let context = coreDataStack.persistentContainer.viewContext
        context.delete(place)
        do {
            try context.save()
        } catch let saveError as NSError {
            print("Failed to delete: \(saveError), \(saveError.userInfo)")
        }
    }
}

