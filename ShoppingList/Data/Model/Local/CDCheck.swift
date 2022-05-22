//
//  CDCheck.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 21.05.2022.
//

import CoreData

final class CDCheck: NSManagedObject {
    
    @NSManaged private(set) var id: String
    @NSManaged private(set) var name: String
    
    static func insert(into context: NSManagedObjectContext, id: String, name: String) -> CDCheck {
        let check: CDCheck = context.insertObject()
        check.id = id
        check.name = name
        return check
    }
}

extension CDCheck: Managed {
  static var defaultSortDescriptors: [NSSortDescriptor] {
    return [NSSortDescriptor(key: #keyPath(id), ascending: false)]
  }
}
