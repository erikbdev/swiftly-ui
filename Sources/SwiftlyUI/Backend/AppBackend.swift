//
//  Backend.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import Foundation

public protocol AppBackend {
  associatedtype Component

  init()

  func runMainLoop(_ callback: @escaping @MainActor () -> Void)

  // @_spi(Internals)
  // func createText(_ node: ViewNode<Text>) -> Component

  // @_spi(Internals)
  // func createButton<V: View>(_ node: ViewNode<Button<V>>) -> Component
}
