import Foundation

@_spi(Internals)
public class Node<V>: AnyNode {
  var object: V

  public init(_ object: V) {
    self.object = object
  }

  public func insertChild<N: AnyNode>(_ child: N) {
    child.parent = self
    self.children.append(child)
  }
}
