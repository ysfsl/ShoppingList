//
//  NetworkDataMapper.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Combine
import Moya

enum PresentableError: Error, Equatable {
    static func == (lhs: PresentableError, rhs: PresentableError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
    
    case networkError(Error)
    case parseError(Error)
    case emptyResponse
}

class NetworkDataMapper {
    func map<T: Decodable>(_ result: AnyPublisher<Response, MoyaError>) -> AnyPublisher<T, PresentableError> {
        result
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> PresentableError in
                switch error {
                case is URLError:
                    return .networkError(error)
                case is DecodingError:
                    return .emptyResponse
                default:
                    return .parseError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
