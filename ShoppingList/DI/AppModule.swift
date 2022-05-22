//
//  AppModule.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerSingletons()
        registerRemote()
        registerRepository()
        registerDomain()
    }
    
    private static func registerSingletons() {
        register { NetworkAdapter() }.scope(.application)
        register { NetworkDataMapper() }.scope(.application)
        register { CoreDataStorage() }.scope(.application)
    }
    
    private static func registerRemote() {
        register { ProductService() as ProductServiceProtocol }
    }
    
    private static func registerRepository() {
        register { ProductRepository() as ProductRepositoryProtocol }
        register { CheckRepository() as CheckRepositoryProtocol }
    }
    
    private static func registerDomain() {
        register { GetProducts() }
        register { AddProduct() }
        register { RemoveProduct() }
        register { InsertCheck() }
        register { RemoveCheck() }
    }
    
}
