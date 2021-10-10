//
//  Location+CoreDataProperties.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//
//

import Foundation
import CoreData

extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var longitude: Double
    @NSManaged public var lattitude: Double
    @NSManaged public var gender: String?
    @NSManaged public var country: String?
    @NSManaged public var image: Data?

}

extension Location : Identifiable {

}
