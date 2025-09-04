//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@_spi(Internals) import SwiftlyUI
import Testing

struct TestApp: App {
  var body: some Scene {
    WindowGroup {
      CounterView()
    }
  }
}

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
    }
  }
}

@Suite("SwiftlyUITests")
struct SwiftlyUITests {
  @Test func layoutNodes() async throws {
    let content = CounterView()
    let root = ViewNode(content)
    CounterView._makeView(root)
    print(root.logTree())
  }
}
