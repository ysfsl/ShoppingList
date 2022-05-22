//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Yusuf Uslu on 20.05.2022.
//

import SwiftUI

@main
struct ShoppingListApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView { ListView(viewModel: ListViewModel()) }
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
