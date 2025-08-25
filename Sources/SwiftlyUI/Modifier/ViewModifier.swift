//
//  ViewModifier.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol ViewModifier {
  associatedtype Body: View
  typealias Content = _ViewModifier_Content<Self>

  @ViewBuilder
  func body(content: Self.Content) -> Self.Body
}

public struct _ViewModifier_Content<Modifier: ViewModifier>: View {
  public typealias Body = Never

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _ViewModifier_Content: PrimitiveView {
  public static func _makePrimitiveView(_ node: Node<Self>) {}
}

extension Never: ViewModifier {
  public typealias Body = Never

  public func body(content: Content) -> Never { fatalError() }
}

@_spi(Internals)
public protocol PrimitiveViewModifier: ViewModifier where Body == Never {
  static func _makeView(_ node: Node<Self>)
}

extension View {
  public nonisolated func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
    ModifiedContent(content: self, modifier: modifier)
  }
}
