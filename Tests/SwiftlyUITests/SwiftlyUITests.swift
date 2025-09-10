//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

import CustomDump
@_spi(Internals) import SwiftlyUI
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
  @State private var internalValue = 0

  var wrappedValue: Int {
    get {
      let currentValue = internalValue
      if internalValue > range.upperBound {
        return range.upperBound
      } else if internalValue < range.lowerBound {
        return range.lowerBound
      } else {
        return currentValue
      }
    }
    nonmutating set {
      self.internalValue = max(range.lowerBound, min(range.upperBound, newValue))
    }
  }
}

@Suite("SwiftlyUITests")
struct SwiftlyUITests {
  @Test func layoutNodes() async throws {
    let root = ViewNode(CounterView())
    CounterView._makeView(root)
    customDump(root)

    // CounterView (Bool)
    //  |-> VStack
    //      |->
  }
}
