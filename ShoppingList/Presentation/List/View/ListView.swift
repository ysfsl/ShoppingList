//
//  ListView.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import SwiftUI
import SwiftAlertView

struct ListView<ViewModel>: View where ViewModel: ListViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
        
    var body: some View {
        content(viewModel.viewState)
            .onAppear {
                viewModel.send(.stateRequested)
            }
            .navigationTitle("Shopping List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        SwiftAlertView.show(title: "Add new product", buttonTitles: "Cancel", "Add") { alertView in
                            alertView.addTextField { textField in
                                textField.placeholder = "Name"
                            }
                        }
                        .onActionButtonClicked({ alertView, buttonIndex in
                            guard let name = alertView.textField(at: 0)?.text else {
                                return
                            }
                            viewModel.send(.addProduct(name: name))
                        })
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

    }
    
    @ViewBuilder
    private func content(_ state: ListViewState) -> some View {
        switch state {
        case .loading:
            ProgressView()
        case .error(let error):
            if error == .emptyResponse {
                Text("Empty")
                    .padding()
            } else {
                Text(error.localizedDescription)
                    .padding()
            }
        case .content(let products):
            List {
                ForEach(products) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Button {
                            if product.isCheck {
                                viewModel.send(.removeCheck(id: product.id))
                            } else {
                                viewModel.send(.addCheck(id: product.id, name: product.name))
                            }
                        } label: {
                            Image(systemName: product.isCheck ? "checkmark.circle.fill" : "checkmark.circle")
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.send(.removeProduct(id: product.id))
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .refreshable {
                viewModel.send(.stateRequested)
            }
            .listStyle(.plain)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
