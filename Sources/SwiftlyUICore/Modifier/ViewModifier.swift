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
  // TODO: pass this in a static func instead?
  let baseNode: AnyNode
  public typealias Body = Never

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _ViewModifier_Content: PrimitiveView {
  public static func _makeView(_ node: Node<Self>) {
    node.view.baseNode.parent = node.parent
    node.view.baseNode.children.append(contentsOf: node.children)
    node.view.baseNode.environmentValues = node.view.baseNode.environmentValues.merging(node.environmentValues)
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
    } else {
      Modifier.Body.makeView(Node(node.view.modifier.body(content: .init(baseNode: Node(node.view.content)))))
    }
 }
}