//
//  Untitled.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

//@MainActor
//@preconcurrency
public protocol View {
  associatedtype Body: View

  @ViewBuilder
  //    @MainActor
  //    @preconcurrency
  var body: Self.Body { get }
}

// @_spi(Internals)
extension View {
  nonisolated static func makeView(_ node: ViewNode<Self>) {
    if let prim = self as? any PrimitiveView.Type {
      func makePrimitiveView<T: PrimitiveView>(_: T.Type) {
        T._makeView(unsafeDowncast(node, to: ViewNode<T>.self))
      }
      makePrimitiveView(prim.self)
    } else if Body.self is Never.Type {
      fatalError("\(Self.self).body cannot have a value of type `Never`")
    } else {
      let body = ViewNode(node.object.body)
      node.insertChild(body)
      Body.makeView(body)
    }
  }
}

extension Never: View {
  public nonisolated var body: Never { self }
}

@_spi(Internals)
public protocol PrimitiveView: View where Body == Never {
  nonisolated static func _makeView(_ node: ViewNode<Self>)
  nonisolated func _visitChildren<V: ViewVisitor>(_ visitor: V)
}

extension PrimitiveView {
  public nonisolated func _visitChildren<V: ViewVisitor>(_ visitor: V) {}
}
