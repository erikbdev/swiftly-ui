//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by Erik Bautista Santibanez on 8/14/25.
//

import Testing

@testable import SwiftlyUI

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
      Text("Hello, World")
    }
  }

  @Test func layoutNodes() async throws {
    let graph = ViewGraph(ContentView())

    #expect(
      graph.logTree() == """
        ContentView
          Text
        """
    )
  }
}
