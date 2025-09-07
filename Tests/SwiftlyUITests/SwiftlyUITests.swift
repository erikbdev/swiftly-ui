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

@Suite("SwiftlyUITests")
struct SwiftlyUITests {
  @Test func layoutNodes() async throws {
    let root = ViewNode(CounterView())
    CounterView._makeView(root)
    customDump(root)
  }
}
