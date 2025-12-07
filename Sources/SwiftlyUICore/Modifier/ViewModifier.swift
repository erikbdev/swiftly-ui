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

@_spi(Internals)
extension ViewModifier {
  public nonisolated static func _makeViewModifier(_ node: Node<Self>) {
    if let prim = self as? any PrimitiveViewModifier.Type {
      func make<T: PrimitiveViewModifier>(_: T.Type) {
        T._makePrimitiveViewModifier(unsafeDowncast(node, to: Node<T>.self))
      }
      make(prim.self)
    } else if Body.self is Never.Type {
      fatalError("\(Self.self).body cannot have a value of type `Never`")
    } else {
      let child = ViewNode(node.object.body(content: .init()))
      node.appendChild(child)
      Body.makeView(child)
    }
  }
}

public struct _ViewModifier_Content<Modifier: ViewModifier>: View {
  public typealias Body = Never

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _ViewModifier_Content: PrimitiveView {
  public static func _makeView(_ node: ViewNode<Self>) {}
}

extension Never: ViewModifier {
  public func body(content: _ViewModifier_Content<Never>) -> Never { fatalError() }
}

@_spi(Internals)
public protocol PrimitiveViewModifier: ViewModifier where Body == Never {
  static func _makePrimitiveViewModifier(_ node: Node<Self>)
}

extension View {
  public nonisolated func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
    ModifiedContent(content: self, modifier: modifier)
  }
}

extension ModifiedContent: View where Content: View, Modifier: ViewModifier, Modifier.Body == Never {
  public var body: Never { fatalError() }

  // TODO: Add this modifier's properties as part of the view that is attached to.
}

// @_spi(Internals)
// extension ModifiedContent: PrimitiveViewModifier where Modifier: ViewModifier {
//     public static func _makePrimitiveViewModifier(_ node: Node<Self>) {}
// }
