/// A View Node that contains the storage of a View.
@_spi(Internals)
public class ViewNode<T: View>: Node<T> {
  public override init(_ view: T) {
    super.init(view)
  }
}

private enum DynamicPropertiesCache {
  private nonisolated(unsafe) static var _cached: [ObjectIdentifier: [any DynamicProperty]] = [:]

  static func fields<T>(for value: T) -> [any DynamicProperty] {
    if let cached = _cached[ObjectIdentifier(T.self)] {
      return cached
    }
    var fields: [any DynamicProperty] = []
    let mirrored = Mirror(reflecting: value)
    switch mirrored.displayStyle {
    case .enum, .optional:
      break
    case .struct, .tuple:
      for child in mirrored.children {

      }
    default:
      break
    }

    _cached[ObjectIdentifier(T.self)] = fields
    return fields
  }
}
