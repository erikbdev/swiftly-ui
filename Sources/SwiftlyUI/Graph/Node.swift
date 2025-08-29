import Foundation

@_spi(Internals)
public class Node<V>: AnyNode {
  let object: V

  public init(_ object: V) {
    self.object = object
  }

  subscript<R>(child: KeyPath<V, R>) -> Node<R> {
    let child = Node<R>(object[keyPath: child])
    child.parent = self
    children.append(child)
    return child
  }

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
