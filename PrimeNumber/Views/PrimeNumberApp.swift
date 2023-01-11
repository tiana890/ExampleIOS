//
//  PrimeNumberApp.swift
//  PrimeNumber
//
//  Created by marina on 27.09.2022.
//

import SwiftUI

@main
struct PrimeNumberApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialValue: AppState(), reducer: appReducer))
        }
    }
}
