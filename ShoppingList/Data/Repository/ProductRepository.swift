//
//  ProductRepository.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Foundation
import Combine
import Resolver
import Alamofire

protocol ProductRepositoryProtocol {
    func getProducts() -> AnyPublisher<[String: ProductResponse], PresentableError>
    func addProduct(product: AddProductRequest) -> AnyPublisher<AddProductResponse, PresentableError>
    func removeProduct(id: String) -> AnyPublisher<Alamofire.Empty, PresentableError>
}

class ProductRepository: ProductRepositoryProtocol {
    
    @Injected private var remoteService: ProductServiceProtocol
    
    func getProducts() -> AnyPublisher<[String: ProductResponse], PresentableError> {
        remoteService.getProducts()
    }
    
    func addProduct(product: AddProductRequest) -> AnyPublisher<AddProductResponse, PresentableError> {
        remoteService.addProduct(product: product)
    }
    
    func removeProduct(id: String) -> AnyPublisher<Alamofire.Empty, PresentableError> {
        remoteService.removeProduct(id: id)
    }
}
