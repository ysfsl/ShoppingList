//
//  PersistenceStore.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 22.05.2022.
//

import CoreData

class PersistenceStore<Entity: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    
    private let persistentContainer: NSPersistentContainer
    private var fetchedResultsController: NSFetchedResultsController<Entity>!
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(_ persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        super.init()
    }
}
