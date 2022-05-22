//
//  Managed.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 22.05.2022.
//

import CoreData

protocol Managed: NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
}

extension Managed where Self: NSManagedObject {
    
    static var entityName: String {
        return entity().name!
    }
    
    static func fetch(in context: NSManagedObjectContext,
                      with sortDescriptors: [NSSortDescriptor] = defaultSortDescriptors,
                      configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        request.sortDescriptors = sortDescriptors
        configurationBlock(request)
        return (try? context.fetch(request)) ?? []
    }
}
