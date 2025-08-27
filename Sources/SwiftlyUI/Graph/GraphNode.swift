import Foundation

// @_spi(Internals)
// public protocol AnyNode: AnyObject {
//   var parent: AnyNode? { get set }
//   var children: [AnyNode] { get set }
//   var root: AnyNode? { get }

//   func logTree(level: Int) -> String
// }

@_spi(Internals)
open class AnyNode {
  weak var parent: AnyNode?
  var children: [AnyNode] = []
  var root: AnyNode? { parent?.root ?? self }

  func logTree(level: Int) -> String { "" }
}

@_spi(Internals)
public final class GraphNode<V>: AnyNode {
  let object: V

  public init(_ object: V) {
    self.object = object
  }

  subscript<R>(child: KeyPath<V, R>) -> GraphNode<R> {
    let child = GraphNode<R>(object[keyPath: child])
    child.parent = self
    children.append(child)
    return child
  }

  let uuid = UUID()

  func insertChild<N: AnyNode>(_ child: N) {
    child.parent = self
    self.children.append(child)
  }

  public override func logTree(level: Int = 0) -> String {
    let indent = Array(repeating: " ", count: level * 2)
      .joined()

    var string = ""
    string += "\(indent)→ \(V.self)"
    for child in children {
      string += "\n" + child.logTree(level: level + 1)
    }
    return string
  }
}

// public final class Weak<T: AnyObject> {
//   weak var value : T?
//   init (_ value: T) {
//     self.value = value
//   }
// } 
