public struct ViewDescriptor {
  @_spi(Internals)
  public var environment: EnvironmentValues

  // TODO: Store modifiers similar to EnvironmentValues? How to evaluate view-like components
  // with state/environment values?
  // var modifiers: []

  @_spi(Internals)
  public func makeUnaryView(_ operation: (inout UnaryViewDescriptor) -> Void) {
    var descriptor = UnaryViewDescriptor()
    operation(&descriptor)
  }

  @_spi(Internals)
  public func makeViewList(_ operation: (inout ViewListDescription) -> Void) {
    var descriptor = ViewListDescription()
    operation(&descriptor)
  }
}

@_spi(Internals)
public struct UnaryViewDescriptor {}

@_spi(Internals)
public struct ViewListDescription {}
