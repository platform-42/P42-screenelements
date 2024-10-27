// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 13.0, *)
struct VScrollView<Content>: View where Content: View {
  @ViewBuilder let content: Content
  
    @available(iOS 13.0.0, *)
    var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        content
          .frame(width: geometry.size.width)
          .frame(minHeight: geometry.size.height)
      }
    }
  }
}
