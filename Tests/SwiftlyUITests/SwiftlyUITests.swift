//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by Erik Bautista Santibanez on 8/14/25.
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
    }
  }

  struct WindowTest: Scene {
    var body: some Scene {
      Window {
        if false {
          Color.red
        }
        Text("Hello")
          .foregroundStyle(.red, .green)
        Button("Bye") {}
      }
    }
  }

  @Test func layoutNodes() async throws {
    let window = WindowTest()
    let root = Node(window)
    WindowTest._makeScene(root)
    print(root.logTree())

    // #expect(
    //   graph.logTree() == """
    //     ContentView
    //       Color
    //       Text
    //     """
    // )
  }
}
