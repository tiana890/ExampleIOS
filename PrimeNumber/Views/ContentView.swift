//
//  ContentView.swift
//  PrimeNumber
//
//  Created by marina on 27.09.2022.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var store: Store<AppState, AppAction>

  var body: some View {
    NavigationView {
      List {
        NavigationLink(
          "Counter demo",
          destination: CounterView(store: self.store)
        )
        NavigationLink(
          "Favorite primes",
          destination: FavoritePrimesView(store: self.store)
        )
      }
      .navigationBarTitle("State management")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialValue: AppState(), reducer: appReducer))
    }
}
