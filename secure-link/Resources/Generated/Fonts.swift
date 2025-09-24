// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Inter {
    internal static let bold = FontConvertible(name: "Inter-Bold", family: "Inter", path: "Inter-Bold.ttf")
    internal static let extraBold = FontConvertible(name: "Inter-ExtraBold", family: "Inter", path: "Inter-ExtraBold.ttf")
    internal static let medium = FontConvertible(name: "Inter-Medium", family: "Inter", path: "Inter-Medium.ttf")
    internal static let regular = FontConvertible(name: "Inter-Regular", family: "Inter", path: "Inter-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Inter-SemiBold", family: "Inter", path: "Inter-SemiBold.ttf")
    internal static let all: [FontConvertible] = [bold, extraBold, medium, regular, semiBold]
  }
  internal enum InterDisplay {
    internal static let semiBold = FontConvertible(name: "InterDisplay-SemiBold", family: "Inter Display", path: "InterDisplay-SemiBold.ttf")
    internal static let all: [FontConvertible] = [semiBold]
  }
  internal enum RedHatDisplay {
    internal static let black = FontConvertible(name: "RedHatDisplay-Black", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let blackItalic = FontConvertible(name: "RedHatDisplay-BlackItalic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let bold = FontConvertible(name: "RedHatDisplay-Bold", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let boldItalic = FontConvertible(name: "RedHatDisplay-BoldItalic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let extraBold = FontConvertible(name: "RedHatDisplay-ExtraBold", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let extraBoldItalic = FontConvertible(name: "RedHatDisplay-ExtraBoldItalic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let italic = FontConvertible(name: "RedHatDisplay-Italic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let light = FontConvertible(name: "RedHatDisplay-Light", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let lightItalic = FontConvertible(name: "RedHatDisplay-LightItalic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let medium = FontConvertible(name: "RedHatDisplay-Medium", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let mediumItalic = FontConvertible(name: "RedHatDisplay-MediumItalic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let regular = FontConvertible(name: "RedHatDisplay-Regular", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let semiBold = FontConvertible(name: "RedHatDisplay-SemiBold", family: "Red Hat Display", path: "RedHatDisplay[wght].ttf")
    internal static let semiBoldItalic = FontConvertible(name: "RedHatDisplay-SemiBoldItalic", family: "Red Hat Display", path: "RedHatDisplay-Italic[wght].ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic]
  }
  internal enum RedHatDisplayVF {
    internal static let black = FontConvertible(name: "RedHatDisplayVF-Black", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let blackItalic = FontConvertible(name: "RedHatDisplayVF-BlackItalic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let bold = FontConvertible(name: "RedHatDisplayVF-Bold", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let boldItalic = FontConvertible(name: "RedHatDisplayVF-BoldItalic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let extraBold = FontConvertible(name: "RedHatDisplayVF-ExtraBold", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let extraBoldItalic = FontConvertible(name: "RedHatDisplayVF-ExtraBoldItalic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let italic = FontConvertible(name: "RedHatDisplayVF-Italic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let light = FontConvertible(name: "RedHatDisplayVF-Light", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let lightItalic = FontConvertible(name: "RedHatDisplayVF-LightItalic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let medium = FontConvertible(name: "RedHatDisplayVF-Medium", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let mediumItalic = FontConvertible(name: "RedHatDisplayVF-MediumItalic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let regular = FontConvertible(name: "RedHatDisplayVF-Regular", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let semiBold = FontConvertible(name: "RedHatDisplayVF-SemiBold", family: "Red Hat Display VF", path: "RedHatDisplayVF.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "RedHatDisplayVF-SemiBoldItalic", family: "Red Hat Display VF", path: "RedHatDisplayVF-Italic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic]
  }
  internal enum Roboto {
    internal static let regular = FontConvertible(name: "Roboto-Regular", family: "Roboto", path: "Roboto-Regular.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal static let allCustomFonts: [FontConvertible] = [Inter.all, InterDisplay.all, RedHatDisplay.all, RedHatDisplayVF.all, Roboto.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
