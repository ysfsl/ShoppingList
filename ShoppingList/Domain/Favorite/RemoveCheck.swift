//
//  RemoveCheck.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 21.05.2022.
//

import Combine
import Resolver

class RemoveCheck {
    
    @Injected private var checkRepository: CheckRepositoryProtocol
        
    func invoke(id: String) -> AnyPublisher<Void, PresentableError> {
        return Future<Void, PresentableError> { promise in
            self.checkRepository.delete(id: id)
          promise(.success(()))
        }
      .eraseToAnyPublisher()
    }
}
