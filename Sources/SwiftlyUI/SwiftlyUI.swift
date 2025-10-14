#if canImport(SwiftUI)
  @_exported import SwiftUI
#else
  // TODO: Support other platforms and backends, use traits?
  @_exported import GtkUI
#endif
