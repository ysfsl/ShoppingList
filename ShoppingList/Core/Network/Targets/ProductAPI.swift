//
//  ProductAPI.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Moya

enum ProductAPI {
    case getProducts
    case addProduct(product: AddProductRequest)
    case removeProduct(id: String)
}

extension ProductAPI: TargetType {
    
    var baseURL: URL {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "products.json"
        case .addProduct:
            return "products.json"
        case .removeProduct(let id):
            return "products/" + id + ".json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts:
               return .get
        case .addProduct:
               return .post
        case .removeProduct:
               return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        case .addProduct(let product):
            return .requestJSONEncodable(product)
        case .removeProduct:
            return .requestPlain
        }
    }
    
    var authorizationType: AuthorizationType? { .none }
    var headers: [String: String]? { nil }
    var sampleData: Data { Data() }
}
