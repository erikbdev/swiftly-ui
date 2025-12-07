//
//  ViewModifier.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol SceneModifier {
  associatedtype Body: Scene
  typealias Content = _SceneModifier_Content<Self>

  @SceneBuilder
  func body(content: Self.Content) -> Self.Body
}

@_spi(Internals)
extension ViewModifier {
  public nonisolated static func _makeSceneModifier(_ node: Node<Self>) {
    if let prim = self as? any PrimitiveSceneModifier.Type {
      func make<T: PrimitiveSceneModifier>(_: T.Type) {
        T._makePrimitiveSceneModifier(unsafeDowncast(node, to: Node<T>.self))
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

public struct _SceneModifier_Content<Modifier: SceneModifier>: Scene {
  public typealias Body = Never

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _SceneModifier_Content: PrimitiveScene {
  public static func _makePrimitiveScene(_ node: SceneNode<Self>) {}
}

extension Never: SceneModifier {
  public func body(content: _SceneModifier_Content<Never>) -> Never { fatalError() }
}

@_spi(Internals)
public protocol PrimitiveSceneModifier: SceneModifier where Body == Never {
  static func _makePrimitiveSceneModifier(_ node: Node<Self>)
}

extension Scene {
  public nonisolated func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
    ModifiedContent(content: self, modifier: modifier)
  }
}

extension ModifiedContent: Scene where Content: Scene, Modifier: SceneModifier, Modifier.Body == Never {
  public var body: Never { fatalError() }

  // TODO: Add this modifier's properties as part of the view that is attached to.
}
