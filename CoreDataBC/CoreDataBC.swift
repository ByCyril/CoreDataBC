//
//  CoreDataModule.swift
//  Stack Report
//
//  Created by Cyril Garcia on 5/10/17.
//  Copyright © 2017 ByCyril. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataBC: Module {
    
    private var entity: String!
    
    
    /// Initialize One CoreData Entity
    ///
    /// - Parameters:
    ///   - entity: The name of your entity you want to access
    ///   - xcDataModelID: The XCDataModelID file name without the extension
    public init(entity: String, xcDataModelID: String) {
        super.init(xcDataModelID: xcDataModelID)
        self.entity = entity
    }
    
    /// Save a single record with only one object. Call the pushMultipleValues() function to save multiple records.
    ///
    /// - Parameter item: A dictionary of type [String: Any]
    public func pushSingleValue<Values>(_ item: [String: Values]) {
        let managedContext = managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: self.entity!, in: managedContext)
        let coreData = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        for i in item {
            let key = i.key
            let value = i.value
            coreData.setValue(value, forKey: key)
        }
        
        do {
            try managedContext.save()
            self.retrieveData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// Save multiple records with an array of objects. Call the pushSingleValue() function to save one record.
    ///
    /// - Parameter items: An array of dictionaries of type [String: Any]
    public func pushMultipleValues<Values>(_ items: [[String: Values]]) {
        for item in items {
            self.pushSingleValue(item)
        }
    }
    
    
    /// Generically retrieve all records from your entity.
    public func retrieveData() {
        let managedContext = managedObjectContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity!)
        
        do {
            let data = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            self.setData(data!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// Retrieves all records and sorted by key.
    ///
    /// - Parameters:
    ///   - byKey: The key you want to sort by
    ///   - ascending: Set to ascending or descending
    public func retrieveAndSort(_ byKey: String, _ ascending: Bool) {
        let managedContext = managedObjectContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity!)
        
        let sectionSortDescriptor = NSSortDescriptor(key: byKey, ascending: ascending)
        let sortDescriptor = [sectionSortDescriptor]
        fetchrequest.sortDescriptors = sortDescriptor
        
        do {
            let data = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            self.setData(data!)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    /// Retrieves data and filters it by value
    ///
    /// - Parameters:
    ///   - value: The value you want to filter by
    ///   - withKey: The key where the value lives in
    public func retriveAndFilterBy<T>(value: T, withKey: String) {
        
        let managedContext = managedObjectContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity!)
        
        var predicate: NSPredicate!
        
        if let intValue = value as? Int {
            predicate = NSPredicate(format: "\(withKey) = %i", intValue)
        }
        
        if let double = value as? Double {
            predicate = NSPredicate(format: "\(withKey) = %f", double)
        }
        
        if let strValue = value as? String {
            predicate = NSPredicate(format: "\(withKey) = %@", strValue)
        }
        
        fetchrequest.predicate = predicate
        
        do {
            let results = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            self.setData(results!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Updating an existing object
    ///
    /// - Parameters:
    ///   - key: The key of the saved object you want to save
    ///   - value: The existing value of that object
    ///   - newValue: The new value you want to replace
    public func update(_ key: String, _ value: String, _ newValue: String) {
        let managedContext = managedObjectContext
        let predicate = NSPredicate(format: key + " == %@", value)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity!)
        fetchRequest.predicate = predicate
        
        do {
            let entities = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            entities.first!.setValue(newValue, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            try managedContext.save()
            self.retrieveData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Remove a specific record by index
    ///
    /// - Parameter index: The index of the record
    public func remove(_ index: Int) {
        let managedContext = managedObjectContext
        managedContext.delete(self.getData()[index])
        self.removeAt(index)
        
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Remove a specific record by object
    ///
    /// - Parameter object: The object to be removed as an NSManagedObject
    public func remove(_ object: NSManagedObject) {
        let managedContext = self.managedObjectContext
        managedContext.delete(object)
        
        do {
            try managedContext.save()
            self.retrieveData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// Remove all records
    public func removeAll() {
        let managedContext = managedObjectContext
        
        for object in self.getData() {
            managedContext.delete(object)
        }
        
        self.clearData()
        
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
   
   
}






