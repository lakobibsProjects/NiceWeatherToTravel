//
//  SightsProvider.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 5/1/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SightsProvider{
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
    var sights:[Sight] = []
    
    init() {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<Sight> = Sight.fetchRequest()
        do{
            sights = try context.fetch(fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataStack.persistentContainer.viewContext
    }
    
    private func getDataFromFile(){
        let fetchRequest: NSFetchRequest<Sight> = Sight.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name != nil")
        
        var records = 0
        
        do{
            records = try context.count(for: fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        guard let pathToFile = Bundle.main.path(forResource: "Sights", ofType: "plist"),
            let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray{
            let entity  = NSEntityDescription.entity(forEntityName: "Sight", in: context)
            let sight = NSManagedObject(entity: entity!, insertInto: context) as! Sight
            
            let sightDictionary = dictionary as! [String : AnyObject]
            sight.city = sightDictionary["city"] as? String
            sight.name = sightDictionary["name"] as? String
            sight.short_description = sightDictionary["short_description"] as? String
            sight.long_description = sightDictionary["long_description"] as? String
            let imageName = sightDictionary["image"] as? String
            guard let image = UIImage(named: imageName!) else { return }
            let imageData = image.pngData()
            sight.image = imageData
        }
    }
}
