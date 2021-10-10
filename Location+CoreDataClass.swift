//
//  Location+CoreDataClass.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//
//

import Foundation
import CoreData
import MapKit

@objc(Location)
public class Location: NSManagedObject, MKAnnotation {

    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(lattitude,longitude)
    }
    public var title: String?{
        return name
    }
    public var subtitle: String?{
        return country
    }
}
