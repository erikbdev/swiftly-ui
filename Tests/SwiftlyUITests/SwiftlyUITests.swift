//
//  SwiftlyUITests.swift
//  SwiftlyUI
//
//  Created by Erik Bautista Santibanez on 8/14/25.
//

import Testing
@testable import SwiftlyUICore

@Suite("SwiftlyUITests")
struct SwiftlyUITests {
    struct TestApp: App {
        var body: some Scene {
            WindowGroup {
                Text("Hello, World!")
                Text("This is a test.")
            }
        }
    }
    
    @Test func layoutNodes() async throws {
//        let app = TestApp()
//        let evaluateNodes = app.createBackend()
    }
}
