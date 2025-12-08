@_spi(Internals)
open class AnyNode {
  weak var parent: AnyNode?
  var children: [AnyNode] = []
  var environmentValues = EnvironmentValues()
  var root: AnyNode? { parent?.root ?? self }
}

extension AnyNode {
  var resolvedEnvironmentValues: EnvironmentValues {
    if let parent = self.parent {
      parent.resolvedEnvironmentValues.merging(environmentValues)
    } else {
      environmentValues
    }
  }

  func tree() -> String {
    treeDescription(level: 0)
  }

  private func treeDescription(level: Int) -> String {
    var str = ""
    let indent = Array(repeating: " ", count: level * 2).joined()
    str += "\(indent)→ \(Self.self)"
    for child in children {
      str += "\n" + child.treeDescription(level: level + 1)
    }
    return str
  }
}
