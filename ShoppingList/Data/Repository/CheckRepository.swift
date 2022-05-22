//
//  CheckRepository.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Foundation
import Combine
import Resolver

protocol CheckRepositoryProtocol {
    func insert(id: String, name: String)
    func delete(id: String)
    func findAll(id: String) -> [CDCheck]
}

class CheckRepository: CheckRepositoryProtocol {
    
    @Injected private var coreDataStorage: CoreDataStorage

    private var store: PersistenceStore<CDCheck> {
        PersistenceStore(coreDataStorage.persistentContainer)
    }
    
    func insert(id: String, name: String) {
        store.insert(id: id, name: name)
    }
    
    func delete(id: String) {
        store.delete(id: id)
    }
    
    func findAll(id: String) -> [CDCheck] {
        store.findAll(for: id)
    }
}
