//
//  Backend.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import Foundation

public protocol AppBackend {
  init()

  func runMainLoop(_ callback: @escaping @MainActor () -> Void)
}
