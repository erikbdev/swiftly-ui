// #if canImport(Logging)
// import Logging

// let logger = Logger(label: "dev.erikb.swiftly-ui.runtime")
// #else
struct Logger {
  func critical(_ message: String) {}
}

let logger = Logger()
// #endif
