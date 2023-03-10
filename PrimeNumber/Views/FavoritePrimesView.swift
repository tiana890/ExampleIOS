//
//  FavoritePrimesView.swift
//  PrimeNumber
//
//  Created by marina on 27.09.2022.
//

import SwiftUI

struct FavoritePrimesView: View {
  @ObservedObject var store: Store<AppState, AppAction>

  var body: some View {
    List {
        ForEach(self.store.value.favoritePrimes, id: \.self) { prime in
        Text("\(prime)")
    
      }
      .onDelete { indexSet in
        self.store.send(.favoritePrimes(.deleteFavoritePrimes(indexSet)))
      }
    }
    .navigationBarTitle("Favorite Primes")
  }
}
struct FavoritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrimesView(store: Store(initialValue: AppState(), reducer: appReducer))
    }
}
