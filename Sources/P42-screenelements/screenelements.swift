// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI


@available(iOS 13.0, *)
public struct ContentHeader: View {
    public var titleLabel: String
    public var logo: String
    public var logoColor: Color
    public var portraitSize: CGFloat
    public var info: String? = nil
    public var width: CGFloat
    public var onLogoTap: (() -> Void)? = nil
    
    public init(
        titleLabel: String,
        logo: String,
        logoColor: Color = .primary,
        portraitSize: CGFloat = 100,
        info: String? = nil,
        width: CGFloat = UIScreen.main.bounds.width * 0.8,
        onLogoTap: (() -> Void)? = nil
    ) {
        self.titleLabel = titleLabel
        self.logo = logo
        self.logoColor = logoColor
        self.portraitSize = portraitSize
        self.info = info
        self.width = width
        self.onLogoTap = onLogoTap
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
                .onTapGesture {
                    onLogoTap?()
                }
            if let info = info {
                Text(info)
                    .font(.body)
                    .padding(.top, 20)
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

@available(iOS 13.0, *)
public struct ButtonLabelWithImage: View {
    public let buttonImageName: String
    public let buttonTitle: String
    public let buttonImageColor: Color
    public let buttonLabelColor: Color
    public let buttonBackgroundColor: Color

    public init(
        buttonImageName: String,
        buttonTitle: String,
        buttonImageColor: Color,
        buttonLabelColor: Color,
        buttonBackgroundColor: Color
    ) {
        self.buttonImageName = buttonImageName
        self.buttonTitle = buttonTitle
        self.buttonImageColor = buttonImageColor
        self.buttonLabelColor = buttonLabelColor
        self.buttonBackgroundColor = buttonBackgroundColor
    }

    public var body: some View {
        HStack {
            Image(systemName: buttonImageName)
                .foregroundColor(buttonImageColor)
            Text(buttonTitle)
                .foregroundColor(buttonLabelColor)
        }
        .padding()
        .background(buttonBackgroundColor)
        .clipShape(Capsule())
    }
}


@available(iOS 14.0, *)
public struct StyledGroupBox<Content: View>: View {
    let title: String
    let icon: String
    let tint: Color
    let background: Color
    let stroke: Color
    let content: Content

    public init(
        title: String,
        icon: String,
        tint: Color,
        background: Color,
        stroke: Color,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.icon = icon
        self.tint = tint
        self.background = background
        self.stroke = stroke
        self.content = content()
    }

    public var body: some View {
        GroupBox(
            label: Label(title.uppercased(), systemImage: icon)
                .foregroundColor(tint)
                .font(.headline)
                .padding(.bottom, 5)
        ) {
            content
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .background(background)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(stroke, lineWidth: 3)
        )
    }
}

