@_spi(Renderer) import SwiftlyUI

open class GtkBackend: AppBackend {
  public typealias Component = AnyObject

  public required init() {}

  public func runMainLoop(_ callback: @escaping @MainActor () -> Void) {}
}
