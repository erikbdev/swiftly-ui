//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import CustomDump
@_spi(Internals) @testable import SwiftlyUI
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
