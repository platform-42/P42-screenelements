// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI


import SwiftUI

@available(iOS 13.0, *)
public struct VScrollView<Content: View>: View {
    private let axis: Axis.Set
    private let content: () -> Content
    
    public init(axis: Axis.Set = .vertical, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    @available(iOS 13.0.0, *)
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(axis) {
                content()
                    .frame(
                        width: axis == .vertical ? geometry.size.width : nil,
                        height: axis == .horizontal ? geometry.size.height : nil
                    )
                    .frame(minHeight: axis == .vertical ? geometry.size.height : nil)
            }
        }
    }
}

