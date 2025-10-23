import SwiftlyUI

// @main
struct DemoApp: App {
  typealias Backend = _Backend
  var body: some Scene {
    WindowGroup {
      Text("Hello, world!")
    }
  }
}

final class _Backend: AppBackend {
  func runMainLoop(_ callback: @escaping () -> Void) {}
}
