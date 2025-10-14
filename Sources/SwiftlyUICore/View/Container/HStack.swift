//
//  HStack.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct HStack<Content: View>: View {
  private var spacing: Int?
  private var alignment: VerticalAlignment
  public var content: Content

  public var body: Never { fatalError() }

  public init(
    alignment: VerticalAlignment = .center,
    spacing: Int? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.alignment = alignment
    self.content = content()
    self.spacing = spacing
  }
}

@_spi(Internals)
extension HStack: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    // Content._makeView(node[\.content])
  }
}
