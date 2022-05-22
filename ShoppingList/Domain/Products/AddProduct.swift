//
//  AddProduct.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 21.05.2022.
//

import Combine
import Resolver

class AddProduct {
    
    @Injected private var productRepository: ProductRepositoryProtocol
    
    func invoke(product: AddProductRequest) -> AnyPublisher<ProductDTO, PresentableError> {
        productRepository.addProduct(product: product).map { response in
            return ProductDTO(id: response.name, name: product.name, isCheck: false)
        }.eraseToAnyPublisher()
    }
}
