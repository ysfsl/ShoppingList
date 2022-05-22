//
//  RemoveProduct.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 21.05.2022.
//

import Combine
import Resolver

class RemoveProduct {
    
    @Injected private var productRepository: ProductRepositoryProtocol
    
    @Injected private var checkRepository: CheckRepositoryProtocol

    func invoke(id: String) -> AnyPublisher<RemoveProductDTO, PresentableError> {
        productRepository.removeProduct(id: id).map { response in
            self.checkRepository.delete(id: id)
            return RemoveProductDTO(id: id)
        }.eraseToAnyPublisher()
    }
}
