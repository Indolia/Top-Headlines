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
    private var newQueue: DispatchQueue!
    
    private init() {
        newQueue = DispatchQueue(label: "new.core.data", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target:nil)
    }
       
    
    // MARK: - Core Data stack
    
    lazy private var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TopHeadLines")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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


fileprivate extension NSManagedObjectContext {
    
    /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
    ///
    /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
    /// - Throws: An error if anything went wrong executing the batch deletion.
  private  func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
    }
}




//  @IBOutlet var textField: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    @IBAction func saved(_ sender: Any) {
//        guard let  someText = textField.text , !someText.isEmpty else{
//            return
//        }
//
//        save(name: someText)
//    }
//
//    @IBAction func fetch(_ sender: Any) {
//        fetchData()
//    }
//    @IBAction func deleteData(_ sender: Any) {
//      deleteData()
//    }
//
//
//
//
//    func save(name: String) {
//
//        // 1
//        let managedContext = CoreDataManager().persistentContainer.viewContext
//
//        // 2
//        let entity = NSEntityDescription.entity(forEntityName: "User",
//                                                in: managedContext)!
//
//        let person = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//
//        // 3
//        person.setValue(name, forKeyPath: "name")
//
//        // 4
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
//
//
//
//    func fetchData() {
//
//
//        let newQueue = DispatchQueue(label: "new.core.data", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target:nil)
//
//        newQueue.async {
//
//            let managedContext = CoreDataManager().persistentContainer.viewContext
//
//            //2
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
//
//            //3
//            do {
//                let users = try managedContext.fetch(fetchRequest)
//                print("fetch count. \(users.count)")
//                for user in users {
//                    print(user.value(forKey: "name"))
//                }
//            } catch let error as NSError {
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
//        }
//
//        DispatchQueue.main.async {
//            print("after core data")
//        }
//    }
//
//
//    func deleteData() {
//        let deleteDataQueue = DispatchQueue(label: "delete.data.core")
//
//        let managedContext = CoreDataManager().persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
//
//        deleteDataQueue.async {
//            do {
//                let users = try managedContext.fetch(fetchRequest)
//                for user in users {
//                    managedContext.delete(user)
//
//                }
//
//                do {
//                    try managedContext.save()
//                } catch let error as NSError {
//                    print("\(error.localizedDescription)")
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//}
