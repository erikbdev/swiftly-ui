//
//  Group.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Group<Content: View>: View {
  public var content: Content
  public var body: Never { fatalError() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}

@_spi(Internals)
extension Group: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    // Content._makeView(node[\.content])
  }
}
