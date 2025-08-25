//
//  Group.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Group<Content: View>: View {
  public let content: Content
  public var body: Never { fatalError() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}

@_spi(Internals)
extension Group: PrimitiveView {
  public nonisolated static func _makeView(_ node: Node<Self>) {}
}