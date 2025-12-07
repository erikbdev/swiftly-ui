import Foundation

@_spi(Internals)
public class Node<T>: AnyNode {
  var object: T

  public init(_ object: T) {
    self.object = object
  }

  public func insertChild<N: AnyNode>(_ child: N) {
    child.parent = self
    self.children.append(child)
  }
}
