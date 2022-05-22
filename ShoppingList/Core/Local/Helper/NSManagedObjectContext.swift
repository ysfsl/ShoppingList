//
//  NSManagedObjectContext.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 21.05.2022.
//

import CoreData

extension NSManagedObjectContext {
    
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
    
    func performChanges(block: @escaping () -> Void) {
        perform {
            block()
            self.saveOrRollback()
        }
    }
    
    func performChangesAndWait(block: () -> Void) {
        performAndWait {
            block()
            self.saveOrRollback()
        }
    }
    
    @discardableResult
    private func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
}
