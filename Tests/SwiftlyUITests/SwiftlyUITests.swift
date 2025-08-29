//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@_spi(Internals) import SwiftlyUI
import Testing

@Suite("SwiftlyUITests")
struct SwiftlyUITests {
  struct TestApp: App {
    var body: some Scene {
      WindowGroup {
        ContentView()
      }
    }
  }

  struct ContentView: View {
    @State private var count = 0

    var body: some View {
      Color.red
      Text("Hello, World")
      // .foregroundStyle(.red)

      if count > 0 {
        Text("I have been clicked!")
      }
    }
  }

  @Test func layoutNodes() async throws {
    let content = ContentView()
    let root = ViewNode(content)
    ContentView._makeView(root)
    print(root.logTree())
  }
}
