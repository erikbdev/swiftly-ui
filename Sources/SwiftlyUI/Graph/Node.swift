import Foundation

@_spi(Internals)
public protocol AnyNode: AnyObject {
  var parent: AnyNode? { get set }
  var children: [AnyNode] { get set }
  var root: AnyNode? { get }

  func logTree(level: Int) -> String
}

@_spi(Internals)
public final class Node<V>: AnyNode {
  // var object: V

  // init(_ object: V) {
  // self.object = object
  // }

  public init() {}

  subscript<R>(child: KeyPath<V, R>) -> Node<R> {
    let child = Node<R>()
    child.parent = self
    children.append(child)
    return child
  }

  public weak var parent: AnyNode?
  var uuid = UUID()
  public var children: [any AnyNode] = []
  public var root: (any AnyNode)? { parent?.root ?? self }

  public func logTree(level: Int = 0) -> String {
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
