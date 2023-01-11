//
//  Action.swift
//  PrimeNumber
//
//  Created by marina on 26.10.2022.
//

import Foundation

enum CounterAction {
  case decrTapped
  case incrTapped
}
enum PrimeModalAction {
  case saveFavoritePrimeTapped
  case removeFavoritePrimeTapped
}
enum FavoritePrimesAction {
  case deleteFavoritePrimes(IndexSet)

  var deleteFavoritePrimes: IndexSet? {
    get {
      guard case let .deleteFavoritePrimes(value) = self else { return nil }
      return value
    }
    set {
      guard case .deleteFavoritePrimes = self, let newValue = newValue else { return }
      self = .deleteFavoritePrimes(newValue)
    }
  }
}

enum AppAction {
  case counter(CounterAction)
  case primeModal(PrimeModalAction)
  case favoritePrimes(FavoritePrimesAction)

  var counter: CounterAction? {
    get {
      guard case let .counter(value) = self else { return nil }
      return value
    }
    set {
      guard case .counter = self, let newValue = newValue else { return }
      self = .counter(newValue)
    }
  }

  var primeModal: PrimeModalAction? {
    get {
      guard case let .primeModal(value) = self else { return nil }
      return value
    }
    set {
      guard case .primeModal = self, let newValue = newValue else { return }
      self = .primeModal(newValue)
    }
  }

  var favoritePrimes: FavoritePrimesAction? {
    get {
      guard case let .favoritePrimes(value) = self else { return nil }
      return value
    }
    set {
      guard case .favoritePrimes = self, let newValue = newValue else { return }
      self = .favoritePrimes(newValue)
    }
  }
}
