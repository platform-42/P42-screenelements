// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI


@available(macOS 10.15, *)
@available(iOS 13.0, *)
public struct ContentHeader: View {
    public var titleLabel: String
    public var titleFontWeight: Font.Weight
    public var logo: String
    public var logoColor: Color
    public var portraitSize: CGFloat
    public var info: String? = nil
    public var onLogoTap: (() -> Void)? = nil
    
    public init(
        titleLabel: String,
        titleFontWeight: Font.Weight = .regular,
        logo: String,
        logoColor: Color = .primary,
        portraitSize: CGFloat = 100,
        info: String? = nil,
        onLogoTap: (() -> Void)? = nil
    ) {
        self.titleLabel = titleLabel
        self.titleFontWeight = titleFontWeight
        self.logo = logo
        self.logoColor = logoColor
        self.portraitSize = portraitSize
        self.info = info
        self.onLogoTap = onLogoTap
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            Text(titleLabel)
                .font(.title)
                .fontWeight(titleFontWeight)
                .padding(.bottom, 5)
            
            if #available(macOS 11.0, *) {
                Image(systemName: logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: portraitSize, height: portraitSize)
                    .foregroundColor(logoColor)
                    .onTapGesture {
                        onLogoTap?()
                    }
            } else {
                // Fallback on earlier versions
            }
            if let info = info {
                Text(info)
                    .font(.body)
                    .padding(.top, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}


@available(macOS 10.15, *)
public struct PageScrollView<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()
        }
    }
}


@available(macOS 10.15, *)
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
            if #available(macOS 11.0, *) {
                Image(systemName: buttonImageName)
                    .foregroundColor(buttonImageColor)
            } else {
                // Fallback on earlier versions
            }
            Text(buttonTitle)
                .foregroundColor(buttonLabelColor)
        }
        .padding()
        .background(buttonBackgroundColor)
        .clipShape(Capsule())
    }
}


@available(macOS 10.15, *)
public struct StyledGroupBox2<Content: View>: View {
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

    @available(macOS 11.0, *)
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .foregroundColor(tint)
                Text(title.uppercased())
                    .foregroundColor(tint)
                    .font(.headline)
            }
            .padding(.bottom, 5)

            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(background)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(stroke, lineWidth: 3)
        )
    }
}


@available(macOS 10.15, *)
@available(iOS 16.0, *)
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
        .frame(maxWidth: .infinity)
        .backgroundStyle(background)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(stroke, lineWidth: 3)
        )
    }
}

