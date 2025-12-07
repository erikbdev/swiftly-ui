import CGTK
@_spi(Renderer) import SwiftlyUICore

open class GtkBackend: Backend {
  // public typealias Component = AnyObject
  var appRef: UnsafeMutablePointer<GtkApplication>?

  public required init() {
    // TODO: Render first render screen, then get all information before starting application.
  }

  public func runMainLoop(_ callback: @escaping @MainActor () -> Void) {
  }
}
