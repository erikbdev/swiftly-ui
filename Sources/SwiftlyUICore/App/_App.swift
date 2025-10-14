final class _App<Root: App> {
  var app: Root
  var backend: Root.Backend
  var environment: EnvironmentValues

  init(_ app: Root) {
    self.app = app
    self.backend = Root.Backend()
    self.environment = EnvironmentValues()
  }

  func run() {
    self.backend.runMainLoop {
        // Update properties before evaluating body.
        
    }
  }
}
