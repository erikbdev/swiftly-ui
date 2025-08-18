//
//  Backend.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import Foundation

open class AppBackend {
  public required init() {
    Foundation.exit(1)
  }

  @MainActor
  func runMainLoop(_ callback: @escaping @MainActor () -> Void) {
    Foundation.exit(1)
  }
}
