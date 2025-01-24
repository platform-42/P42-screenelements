// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI


import SwiftUI


@available(iOS 13.0, *)
public struct ContentHeader: View {
    public var titleLabel: String
    public var logo: String
    public var logoColor: Color
    public var portraitSize: CGFloat
    public var info: String? = nil
    public var width: CGFloat

    public init(
        titleLabel: String,
        logo: String,
        logoColor: Color = .primary,
        portraitSize: CGFloat = 100,
        info: String? = nil,
        width: CGFloat = UIScreen.main.bounds.width * 0.8
    ) {
        self.titleLabel = titleLabel
        self.logo = logo
        self.logoColor = logoColor
        self.portraitSize = portraitSize
        self.info = info
        self.width = width
    }

    public var body: some View {
        VStack(spacing: 10) {
            Text(titleLabel)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)

            Image(systemName: logo)
                .resizable()
                .scaledToFit()
                .frame(width: portraitSize, height: portraitSize)
                .foregroundColor(logoColor)

            if let info = info {
                Text(info)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
            }
        }
        .frame(width: width)
        .padding()
    }
}


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

