//
//  ZStack.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct ZStack<Content: View>: View {
  public var content: Content
  public var body: Never { fatalError() }
  public var alignment: Alignment

  public init(
    alignment: Alignment = .center,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.alignment = alignment
  }
}

@_spi(Internals)
extension ZStack: PrimitiveView {
  public nonisolated static func _makeView(_ node: Node<Self>) {}
}