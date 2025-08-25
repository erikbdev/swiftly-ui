public protocol ModifierKey {
  associatedtype Root
  associatedtype Value
}

public struct ModifierValues<Root> {
  private var storage: [ObjectIdentifier: Any] = [:]

  subscript<K: ModifierKey>(_ key: K.Type) -> K.Value? where K.Root == Root {
    get {
      storage[ObjectIdentifier(K.self)] as? K.Value
    }
    set {
      storage[ObjectIdentifier(K.self)] = newValue
    }
  }
}
