//
//  CoreDataManager.swift
//  Top Headlines
//
//  Created by Rishi pal on 09/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    static let share = CoreDataManager()
   
    
    // MARK: - Core Data stack
    
    lazy private var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TopHeadLines")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func  saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func viewContext()-> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    
    func deleteAll(for deleteRequest: NSBatchDeleteRequest) {
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        }catch let error  {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
}

//MARK: - Core data delete support
fileprivate extension NSManagedObjectContext {

  private  func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
    }
}
