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
public protocol PrimitiveViewModifier: ViewModifier where Body == Never {
  static func _makeViewModifier<T: View>(_ modifier: Self, for node: Node<T>)
}

@_spi(Internals)
extension PrimitiveViewModifier {
  public func body(content: _ViewModifier_Content<Self>) -> Never {
    fatalError()
  }
}

public struct _ViewModifier_Content<Modifier: ViewModifier>: View {
  let baseNode: AnyNode
  let viewType: any View.Type

  fileprivate init<V: View>(_ node: Node<V>) {
    self.baseNode = node
    self.viewType = V.self
  }

  public typealias Body = Never

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _ViewModifier_Content: PrimitiveView {
  public static func _makeView(_ node: Node<Self>) {
    func _castView<V: View>(_ type: V.Type) {
      node.appendChild(node.view.baseNode as! Node<V>)
    }
    _castView(node.view.viewType)
  }
}

extension Never: ViewModifier {
  public func body(content: _ViewModifier_Content<Never>) -> Never { fatalError() }
}

extension View {
  public nonisolated func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
    ModifiedContent(content: self, modifier: modifier)
  }
}

extension ModifiedContent: View where Content: View, Modifier: ViewModifier {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension ModifiedContent: PrimitiveView where Content: View, Modifier: ViewModifier {
  public static func _makeView(_ node: Node<Self>) {
    bindProperties(&node.view.modifier, storage: &node.properties, inputs: DynamicPropertyInputs(environmentValues: node.resolvedEnvironmentValues))
    if let primitiveType = Modifier.self as? any PrimitiveViewModifier.Type {
      func _makeViewModifier<U: PrimitiveViewModifier>(_ type: U.Type) {
        node.appendChild(Node(node.view.content))
        U._makeViewModifier(node.view.modifier as! U, for: node)
      }
      _makeViewModifier(primitiveType)
    } else if Modifier.Body.self is Never.Type {
      fatalError("\(Modifier.self).Body cannot be of type `Never`")
    } else {
      node.appendChild(Node(node.view.modifier.body(content: .init(Node(node.view.content)))))
    }
  }
}
