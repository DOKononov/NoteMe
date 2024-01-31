//
//  CoreDataService.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//

import CoreData

final class CoreDataService {
    
    typealias CompletionHandler = ((Bool) ->  Void)
    static let shared: CoreDataService = .init()
    private init() {}
    
     var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var persistentContainer: NSPersistentContainer = {
            let modelName = "NotificationDataBase"
            let bundle = Bundle(for: CoreDataService.self)
            
            guard
                let modelURL = bundle.url(forResource: modelName, withExtension: "momd"),
                let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
            else { fatalError("unable to find model in bundle") }

            let container = NSPersistentContainer(name: modelName,
                                                  managedObjectModel: managedObjectModel)
            
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

    
    func saveContext (completion: CompletionHandler? = nil) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion?(true)
            } catch {
                let nserror = error as NSError
                completion?(false)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
