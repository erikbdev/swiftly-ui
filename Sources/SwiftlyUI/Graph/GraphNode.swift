import Foundation

@_spi(Internals)
public protocol AnyNode: AnyObject {
  var parent: AnyNode? { get set }
  var children: [AnyNode] { get set }
  var root: AnyNode? { get }

  func logTree(level: Int) -> String
}

@_spi(Internals)
public final class GraphNode<V>: AnyNode {
  let object: V

  public init(_ object: V) {
    self.object = object
  }

  // public init() {}

  subscript<R>(child: KeyPath<V, R>) -> GraphNode<R> {
    let child = GraphNode<R>(object[keyPath: child])
    child.parent = self
    children.append(child)
    return child
  }

  public weak var parent: AnyNode?
  var uuid = UUID()
  public var children: [any AnyNode] = []
  public var root: (any AnyNode)? { parent?.root ?? self }

  func insertChild<N: AnyNode>(_ node: N) {
    node.parent = self
    self.children.append(node)
  }

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
