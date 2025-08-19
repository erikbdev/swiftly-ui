protocol _Location<Value> {
  associatedtype Value
  func get() -> Value
  mutating func set(_ value: Value, transaction: Transaction)
}

final class AnyLocation<Value>: _Location {
  var base: any _Location<Value>

  init(_ location: some _Location<Value>) {
    self.base = location
  }

  func get() -> Value {
    base.get()
  }

  func set(_ value: Value, transaction: Transaction) {
    base.set(value, transaction: transaction)
  }
}

struct ConstantLocation<Value>: _Location {
  let value: Value
  func get() -> Value { value }
  func set(_ value: Value, transaction: Transaction) {}
}

struct FunctionLocation<Value>: _Location {
  let getValue: () -> Value
  let setValue: (Value, Transaction) -> Void

  func get() -> Value {
    self.getValue()
  }

  func set(_ value: Value, transaction: Transaction) {
    self.setValue(value, transaction)
  }
}
