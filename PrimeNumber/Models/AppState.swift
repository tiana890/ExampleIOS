//
//  AppState.swift
//  PrimeNumber
//
//  Created by marina on 27.09.2022.
//

import Combine
import SwiftUI

struct AppState {
  var count = 0
  var favoritePrimes: [Int] = []
  var loggedInUser: User? = nil
  var activityFeed: [Activity] = []

  struct Activity {
    let timestamp: Date
    let type: ActivityType

    enum ActivityType {
      case addedFavoritePrime(Int)
      case removedFavoritePrime(Int)

      var addedFavoritePrime: Int? {
        get {
          guard case let .addedFavoritePrime(value) = self else { return nil }
          return value
        }
        set {
          guard case .addedFavoritePrime = self, let newValue = newValue else { return }
          self = .addedFavoritePrime(newValue)
        }
      }

      var removedFavoritePrime: Int? {
        get {
          guard case let .removedFavoritePrime(value) = self else { return nil }
          return value
        }
        set {
          guard case .removedFavoritePrime = self, let newValue = newValue else { return }
          self = .removedFavoritePrime(newValue)
        }
      }
    }
  }

  struct User {
    let id: Int
    let name: String
    let bio: String
  }
}

struct FavoritePrimesState {
  var favoritePrimes: [Int]
  var activityFeed: [AppState.Activity]
}

extension AppState {
    var favoritePrimesState: FavoritePrimesState {
        get {
            FavoritePrimesState(
                favoritePrimes: self.favoritePrimes,
                activityFeed: self.activityFeed
            )
        }
        set {
            self.favoritePrimes = newValue.favoritePrimes
            self.activityFeed = newValue.activityFeed
        }
    }
}

struct _KeyPath<Root, Value> {
  let get: (Root) -> Value
  let set: (inout Root, Value) -> Void
}

