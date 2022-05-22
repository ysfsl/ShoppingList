//
//  CoreDataStorage.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import CoreData

final class CoreDataStorage {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
