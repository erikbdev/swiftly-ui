//
//  ZStack.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct VStack<Content: View>: View {
  public var spacing: Int?
  public var alignment: HorizontalAlignment
  public var content: Content
  public var body: Never { fatalError() }

  public init(
    alignment: HorizontalAlignment = .center,
    spacing: Int? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.alignment = alignment
    self.content = content()
    self.spacing = spacing
  }
}

@_spi(Internals)
extension VStack: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
  }
  public nonisolated func _visitChildren<V: ViewVisitor>(_ visitor: V) {
    visitor.visit(content)
  }
}
