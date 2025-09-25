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

  var body: some View {
    VStack {
      Button("Decrease") {
        count -= 1
      }
      Text("Count: \(count)")
      Button("Increase") {
        count += 1
      }
      if count > 5 {
        Text("Hello, there!")
      }
    }
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
    CounterView._makeView(root)
    customDump(root)

    // CounterView
    //  |-> VStack
    //      |->
  }
}
