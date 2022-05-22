//
//  CDCheck+PersistenceStore.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 22.05.2022.
//

import CoreData

extension PersistenceStore where Entity == CDCheck {
    
    func insert(id: String, name: String) {
        managedObjectContext.performChanges { [managedObjectContext] in
            _ = CDCheck.insert(into: managedObjectContext, id: id, name: name)
        }
    }
    
    func delete(id: String) {
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDCheck.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try managedObjectContext.execute(deleteRequest)
        } catch { }
    }
    
    func findAll(for id: String) -> [CDCheck] {
        return CDCheck.fetch(in: managedObjectContext, configurationBlock: { request in
            request.predicate = NSPredicate(format: "id = %@", id)
        })
    }
}
