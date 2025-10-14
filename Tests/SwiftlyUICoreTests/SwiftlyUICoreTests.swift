//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import CustomDump
@_spi(Internals) @testable import SwiftlyUICore
import Testing

struct CounterView: View {
  @State var count = 0
  @Clamped(range: 0...10) var clampedCounter
  @State var greetingName = "John"

  var body: some View {
    VStack {
      Button("Decrease") {
        count -= 1
      }
      Text("Count: \(count)")
      DefaultValueEnvironmentView()
        .environment(\.defaultText, "Jose")
      Button("Increase") {
        count += 1
      }
      if count > 5 {
        Text("Hello, \(greetingName)")
      }
    }
    EmptyView()
  }
}

private struct DefaultValueEnvironmentView: View {
  @Environment(\.defaultText) var environmentName

  var body: some View {
    Text("Environment default name: \(environmentName)")
  }
}

@propertyWrapper
private struct Clamped: DynamicProperty {
  let range: ClosedRange<Int>
  @State private var _value = 0

  var wrappedValue: Int {
    get {
      let currentValue = _value
      if currentValue > range.upperBound {
        return range.upperBound
      } else if currentValue < range.lowerBound {
        return range.lowerBound
      } else {
        return currentValue
      }
    }
    nonmutating set {
      self._value = max(range.lowerBound, min(range.upperBound, newValue))
    }
  }
}

private struct SwiftlyUIVisitor: ViewVisitor {
  let viewVisited: (ObjectIdentifier) -> Void

  func visit<V>(_ view: V) where V: View {
    viewVisited(ObjectIdentifier(V.self))
  }
}

@Suite("SwiftlyUITests")
struct SwiftlyUITests {
  @Test func layoutNodes() async throws {
    let root = ViewNode(CounterView())

    root.property(\.$count) { $property in
      property = 6
    }

    root.property(\.$greetingName) { $property in
      property = "Jane"
    }
    root.reevaluate()
    customDump(root, name: "After setting  counter to 6")
  }

  @Test func dynamicPropertiesCounter() {
    let descriptors = DynamicPropertyBuffer.descriptors(of: CounterView.self)
    // #expect(descriptors.count == 2)

    dump(descriptors)
  }

  @Test func testViewVisitor() {
    var storage: [ObjectIdentifier] = []
    let visitor = SwiftlyUIVisitor {
      storage.append($0)
    }

    let root = ViewNode(CounterView())
    root.object.visitChildren(visitor)

    customDump(storage, name: "\(CounterView.self) body")
  }
}

extension EnvironmentValues {
  private enum DefaultValue: EnvironmentKey {
    static let defaultValue = "Jane"
  }

  var defaultText: String {
    get { self[DefaultValue.self] }
    set { self[DefaultValue.self] = newValue }
  }
}
