//
//  Backend.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

#if canImport(Foundation)
  import Foundation
#endif

public protocol AppBackend {
  // associatedtype Component

  init()

  func runMainLoop(_ callback: @escaping () -> Void)

  // @_spi(Internals)
  // func createText(_ node: ViewNode<Text>) -> Component

  // @_spi(Internals)
  // func createButton<V: View>(_ node: ViewNode<Button<V>>) -> Component
}
