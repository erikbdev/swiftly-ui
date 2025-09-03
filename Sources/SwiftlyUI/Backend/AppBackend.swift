//
//  Backend.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import Foundation

open class AppBackend {
  public required init() {
  }

  @MainActor
  func runMainLoop(_ callback: @escaping @MainActor () -> Void) {
    fatalError()
  }
}
