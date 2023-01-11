//
//  Store.swift
//  PrimeNumber
//
//  Created by marina on 05.10.2022.
//

import Foundation
import UIKit

final class Store<Value, Action>: ObservableObject {
    @Published var value: Value
    let reducer: (inout Value, Action) -> Void
    
    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.value = initialValue
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        self.reducer(&self.value, action)
    }
    
}
