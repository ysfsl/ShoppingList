//
//  NetworkAdapter.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Combine
import Moya
import Alamofire

class NetworkAdapter {
    
    private let provider: MoyaProvider<MultiTarget>
    
    private let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        let session = Alamofire.Session(configuration: configuration, startRequestsImmediately: false)
        return session
    }()
        
    init() {
        provider = MoyaProvider<MultiTarget>(session: session, plugins: [])
    }
    
    func request(target: TargetType) -> AnyPublisher<Response, MoyaError> {
        return provider.requestPublisher(MultiTarget(target))
                .filterSuccessfulStatusCodes()
                .eraseToAnyPublisher()
    }
}
