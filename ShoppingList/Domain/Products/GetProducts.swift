//
//  GetProducts.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Combine
import Resolver

class GetProducts {
    
    @Injected private var productRepository: ProductRepositoryProtocol
    
    @Injected private var checkRepository: CheckRepositoryProtocol
    
    func invoke() -> AnyPublisher<[ProductDTO], PresentableError> {
        productRepository.getProducts().map { response in
            return response.map { (key, value) in
                let entity = self.checkRepository.findAll(id: key)
                return ProductDTO(id: key, name: value.name, isCheck: !entity.isEmpty)
            }.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
        }.eraseToAnyPublisher()
    }
}
