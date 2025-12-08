//
//  View.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol View {
  associatedtype Body: View

  @ViewBuilder
  var body: Self.Body { get }
}

extension View {
  nonisolated static func makeView(_ node: Node<Self>) {
    if let prim = self as? any PrimitiveView.Type {
      func makePrimitiveView<T: PrimitiveView>(_: T.Type) {
        T._makeView(node as! Node<T>)
      }
      makePrimitiveView(prim.self)
    } else if Body.self is Never.Type {
      fatalError("\(Self.self).body cannot have a value of type `Never`")
    } else {
      node.appendChild(Node(node.object.body))
    }
  }
}

extension Never: View {
  public nonisolated var body: Never { self }
}

@_spi(Internals)
public protocol PrimitiveView: View where Body == Never {
  nonisolated static func _makeView(_ node: Node<Self>)
  // nonisolated static func _updateView(_ node: Node<Self>, newView: Self)
}
