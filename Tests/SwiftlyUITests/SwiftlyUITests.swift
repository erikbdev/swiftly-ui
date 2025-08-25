//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by Erik Bautista Santibanez on 8/14/25.
//

import Testing

@_spi(Internals) import SwiftlyUI

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
        Text("Hello")
        Button("Bye") {}
      }
    }
  }

  @Test func layoutNodes() async throws {
    // let window = WindowTest()
    let root = Node<WindowTest>()
    WindowTest._makeScene(root)
    print(root.logTree())
    // let graph = ViewGraph(ContentView())

    // #expect(
    //   graph.logTree() == """
    //     ContentView
    //       Color
    //       Text
    //     """
    // )
  }
}
