//
//  DataSource.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//

import UIKit
import CoreData

class DataSource {
    
    public var context:NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var locations:[Location]? = nil
    
    
    func fetchLocations(filter:String){
        let request = Location.fetchRequest() as NSFetchRequest<Location>
        if(!filter.isEmpty){
            request.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR country CONTAINS[c] %@", filter, filter)
        }
        do{
            locations = try context.fetch(request)
            print("Got locations data. Count: \(String(describing: locations?.count))")
        } catch{
            print("Error getting locations data")
        }
    }
    
    func saveLocations(name:String, birthday:Date, country:String, gender:String, latti:Double, longi:Double, image:Data)->Bool{
        
        let locationData = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as! Location
        locationData.birthday = birthday
        locationData.country = country
        locationData.gender = gender
        locationData.lattitude = latti
        locationData.longitude = longi
        locationData.name = name
        locationData.image = image
        
        do{
            try context.save()
            print("Data saved successfully \(Location.description())")
            return true
        } catch{
            print("Error saving data")
            return false
        }
    }
    
    func delete(location:Location, index:Int) -> Bool{
        locations?.remove(at: index)
        context?.delete(location)
        do{
            try context?.save()
            print("Delete success")
            return true
        }catch{
            print("Error while Delete data")
            return false
        }
    }
    
    func update(location:Location, index:Int) -> Bool{
        locations?[index] = location
        do{
            try context?.save()
            print("Update success")
            return true
        }catch{
            print("Error while updating data")
            return false
        }
    }
}
