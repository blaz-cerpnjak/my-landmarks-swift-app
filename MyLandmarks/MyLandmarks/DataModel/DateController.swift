//
//  DateController.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 26/08/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "LandmarkModel")
    @Published var landmarks: [Landmark] = []
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
        fetchLandmarks()
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            fetchLandmarks()
            print("Data saved")
        } catch {
            print("Data could not be saved...")
        }
    }
    
    func fetchLandmarks() {
        let request = NSFetchRequest<Landmark>(entityName: "Landmark")
        
        do {
            landmarks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addLandmark(name: String, category: String, desc: String, lat: Double, lon: Double, imageData: Data?, context: NSManagedObjectContext) {
        let landmark = Landmark(context: context)
        landmark.id = UUID()
        landmark.date = Date()
        landmark.name = name
        landmark.desc = desc
        landmark.imageData = imageData
        landmark.category = category
        landmark.latitude = lat
        landmark.longitude = lon
        
        save(context: context)
    }
    
    func editLandmark(landmark: Landmark, name: String, category: String, desc: String, lat: Double, lon: Double, imageData: Data?, context: NSManagedObjectContext) {
        landmark.id = landmark.id
        landmark.date = landmark.date
        landmark.name = name
        landmark.desc = desc
        landmark.imageData = imageData ?? landmark.imageData
        landmark.category = category
        landmark.latitude = lat
        landmark.longitude = lon
        
        save(context: context)
    }
    
    func deleteLandmark(landmark: Landmark, context: NSManagedObjectContext) {
        context.delete(landmark)
        
        save(context: context)
    }
    
    func setFavorite(landmark: Landmark, isFavorite: Bool, context: NSManagedObjectContext) {
        landmark.isFavorite = isFavorite
        
        save(context: context)
    }
    
    func deleteLandmark(indexSet: IndexSet, context: NSManagedObjectContext) {
        guard let index = indexSet.first else { return }
        let landmark = landmarks[index]
        container.viewContext.delete(landmark)
        save(context: context)
    }
}
