//
//  ListViewModel.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Foundation
import Combine
import Resolver

final class ListViewModel: ListViewModelProtocol {
    
    @Injected var getProducts: GetProducts
    
    @Injected var addProducts: AddProduct
    
    @Injected var removeProducts: RemoveProduct
    
    @Injected var insertCheck: InsertCheck

    @Injected var removeCheck: RemoveCheck
    
    @Published var viewState: ListViewState = .loading
    
    var inputSubject = PassthroughSubject<ListInput, Never>()
    
    init() {
        inputSubject
            .flatMap { [getProducts] input -> AnyPublisher<ListAction, Never> in
                switch input {
                case .stateRequested:
                    return getProducts.invoke()
                        .map { products -> ListAction in
                            .setState(.content(products: products))
                        }
                        .catch { Just(.setState(.error($0))) }
                        .eraseToAnyPublisher()
                case .addProduct(let name):
                    return self.addProducts.invoke(product: .init(name: name))
                        .map { product -> ListAction in
                                .addProduct(product: product)
                        }
                        .catch { Just(.setState(.error($0))) }
                        .eraseToAnyPublisher()
                case .removeProduct(let id):
                    return self.removeProducts.invoke(id: id)
                        .map { _ -> ListAction in
                                .removeProduct(id: id)
                        }
                        .catch { Just(.setState(.error($0))) }
                        .eraseToAnyPublisher()
                case .addCheck(let id, let name):
                    return self.insertCheck.invoke(id: id, name: name)
                        .map { _ -> ListAction in
                                .setCheck(id: id, isCheck: true)
                        }
                        .catch { Just(.setState(.error($0))) }
                        .eraseToAnyPublisher()
                case .removeCheck(let id):
                    return self.removeCheck.invoke(id: id)
                        .map { _ -> ListAction in
                                .setCheck(id: id, isCheck: false)
                        }
                        .catch { Just(.setState(.error($0))) }
                        .eraseToAnyPublisher()
                }
            }.scan(viewState) { (currentState, action) -> ListViewState in
                switch action {
                case .setState(let state):
                    return state
                case .addProduct(let product):
                    if case .content(var products) = currentState {
                        products.append(product)
                        products.sort(by: {$0.name < $1.name})
                        return .content(products: products)
                    } else {
                        return .content(products: [product])
                    }
                case .removeProduct(let id):
                    if case .content(var products) = currentState {
                        products.removeAll(where: { $0.id == id })
                        if products.isEmpty {
                            return .error(.emptyResponse)
                        } else {
                            return .content(products: products)
                        }
                    }
                    return currentState
                case .setCheck(let id, let isCheck):
                    if case .content(var products) = currentState {
                        for index in products.indices where products[index].id == id {
                            products[index].isCheck = isCheck
                        }
                        return .content(products: products)
                    }
                    return currentState
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$viewState)
    }
    
    func send(_ input: ListInput) {
        inputSubject.send(input)
    }
}
