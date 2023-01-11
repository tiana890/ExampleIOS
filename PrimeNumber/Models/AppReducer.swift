//
//  CounterReducer.swift
//  PrimeNumber
//
//  Created by marina on 10.10.2022.
//

import Foundation
import SwiftUI

struct EnumKeyPath<Root, Value> {
  let embed: (Value) -> Root
  let extract: (Root) -> Value?
}

func appReducer(value: inout AppState, action: AppAction) -> Void {
    let _appReducer: (inout AppState, AppAction) -> Void = combine(
        pullback(counterReducer, value: \.count, action: \.counter),
        pullback(primeModalReducer, value: \.self, action: \.primeModal),
        pullback(favoritePrimesReducer, value: \.favoritePrimesState, action: \.favoritePrimes)
    )
    _appReducer(&value, action)
}


func counterReducer(state: inout Int, action: CounterAction) {
  switch action {
  case .decrTapped:
    state -= 1

  case .incrTapped:
    state += 1
  }
}

func primeModalReducer(state: inout AppState, action: PrimeModalAction) -> Void {
  switch action {
  case .removeFavoritePrimeTapped:
    state.favoritePrimes.removeAll(where: { $0 == state.count })
    state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.count)))

  case .saveFavoritePrimeTapped:
    state.favoritePrimes.append(state.count)
    state.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(state.count)))
  }
}

func favoritePrimesReducer(state: inout FavoritePrimesState, action: FavoritePrimesAction) -> Void {
  switch action {
  case let .deleteFavoritePrimes(indexSet):
    for index in indexSet {
      state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.favoritePrimes[index])))
      state.favoritePrimes.remove(at: index)
    }
  }
}


func combine<Value, Action>(
  _ reducers: (inout Value, Action) -> Void...
) -> (inout Value, Action) -> Void {
    return { val, act in
        for reducer in reducers {
            reducer(&val, act)
        }
    }
}

func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
  _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
  value: WritableKeyPath<GlobalValue, LocalValue>,
  action: WritableKeyPath<GlobalAction, LocalAction?>
) -> (inout GlobalValue, GlobalAction) -> Void {
  return { globalValue, globalAction in
    guard let localAction = globalAction[keyPath: action] else { return }
    reducer(&globalValue[keyPath: value], localAction)
  }
}



