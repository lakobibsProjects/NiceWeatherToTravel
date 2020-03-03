//
//  Sight+CoreDataProperties.swift
//  
//
//  Created by user166683 on 3/2/20.
//
//

import Foundation
import CoreData


extension Sight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sight> {
        return NSFetchRequest<Sight>(entityName: "Sight")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var short_description: String?
    @NSManaged public var long_description: String?
    @NSManaged public var city: String?

}
