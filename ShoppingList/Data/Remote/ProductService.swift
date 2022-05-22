//
//  ProductService.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Foundation
import Resolver
import Moya
import Combine
import Alamofire

protocol ProductServiceProtocol {
    func getProducts() -> AnyPublisher<[String: ProductResponse], PresentableError>
    func addProduct(product: AddProductRequest) -> AnyPublisher<AddProductResponse, PresentableError>
    func removeProduct(id: String) -> AnyPublisher<Alamofire.Empty, PresentableError>
}

class ProductService: ProductServiceProtocol {
    
    @Injected private var networkAdapter: NetworkAdapter
        
    @Injected private var dataMapper: NetworkDataMapper
        
    func getProducts() -> AnyPublisher<[String: ProductResponse], PresentableError> {
        return dataMapper.map(networkAdapter.request(target: ProductAPI.getProducts))
    }
    
    func addProduct(product: AddProductRequest) -> AnyPublisher<AddProductResponse, PresentableError> {
        return dataMapper.map(networkAdapter.request(target: ProductAPI.addProduct(product: product)))
    }
    
    func removeProduct(id: String) -> AnyPublisher<Alamofire.Empty, PresentableError> {
        return dataMapper.map(networkAdapter.request(target: ProductAPI.removeProduct(id: id)))
    }
}
