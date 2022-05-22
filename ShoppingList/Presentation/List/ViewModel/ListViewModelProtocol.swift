//
//  ListViewModelProtocol.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import Combine

enum ListViewState {
    case loading
    case content(products: [ProductDTO])
    case error(_ error: PresentableError)
}

enum ListInput {
    case stateRequested
    case addProduct(name: String)
    case removeProduct(id: String)
    case addCheck(id: String, name: String)
    case removeCheck(id: String)
}

enum ListAction {
    case setState(ListViewState)
    case addProduct(product: ProductDTO)
    case removeProduct(id: String)
    case setCheck(id: String, isCheck: Bool)
}

protocol ListViewModelProtocol: ObservableObject {
    var viewState: ListViewState { get }
    var inputSubject: PassthroughSubject<ListInput, Never> { get }
    func send(_ input: ListInput)
}
