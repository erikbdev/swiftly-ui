//
//  Scene.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

//@MainActor
//@preconcurrency
public protocol Scene {
  associatedtype Body: Scene

  @SceneBuilder
  //    @MainActor
  //    @preconcurrency
  var body: Self.Body { get }
}

extension Never: Scene {}

@_spi(Internals)
extension Scene {
  @_disfavoredOverload
  public nonisolated static func _makeScene(_ node: Node<Self>) {
    if let prim = self as? any PrimitiveScene.Type {
      func makePrimitiveScene<T: PrimitiveScene>(_: T.Type) {
        T._makePrimitiveScene(node as! Node<T>)
      }
      makePrimitiveScene(prim.self)
    } else if Body.self is Never.Type {
      fatalError("\(Self.self).body cannot have a value of type `Never`")
    } else {
      // Body._makeScene(node[\.body])
    }
  }
}

extension Scene where Body == Never {
  public var body: Never { sceneBodyNever() }
}

@_spi(Internals)
public protocol PrimitiveScene: Scene where Body == Never {
  var body: Never { get }

  nonisolated static func _makePrimitiveScene(_ node: Node<Self>)
}

@_spi(Internals)
public func sceneBodyNever() -> Never {
  fatalError("Scene.body of type `\(Never.self)` is not accessible")
}
