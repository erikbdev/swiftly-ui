/// A View Node that contains the storage of a View.
@_spi(Internals)
public class ViewNode<T: View>: Node<T> {
  var properties = DynamicPropertyBuffer()

  func makeBody(_ operation: () -> Void) {
    // Resolve all properties before accessing body.
    let descriptors = DynamicPropertyBuffer.descriptors(of: T.self)
    if properties.fields.isEmpty, !descriptors.isEmpty {
      for descriptor in descriptors {
        descriptor.type.makeProperty(&properties)
      }
    }
  }
}
