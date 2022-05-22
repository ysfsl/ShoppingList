//
//  InsertCheck.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Combine
import Resolver

class InsertCheck {
    
    @Injected private var checkRepository: CheckRepositoryProtocol
    
    func invoke(id: String, name: String) -> AnyPublisher<Void, PresentableError> {
          return Future<Void, PresentableError> { promise in
              self.checkRepository.insert(id: id, name: name)
            promise(.success(()))
          }
        .eraseToAnyPublisher()
    }
}
