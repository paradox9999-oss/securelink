// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// Back
    internal static let back = L10n.tr("Localizable", "Common.Back", fallback: "Back")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Common.Cancel", fallback: "Cancel")
    /// Continue
    internal static let `continue` = L10n.tr("Localizable", "Common.Continue", fallback: "Continue")
    /// Edit
    internal static let edit = L10n.tr("Localizable", "Common.Edit", fallback: "Edit")
    /// Later
    internal static let later = L10n.tr("Localizable", "Common.Later", fallback: "Later")
    /// OK
    internal static let ok = L10n.tr("Localizable", "Common.Ok", fallback: "OK")
    /// Preview
    internal static let preview = L10n.tr("Localizable", "Common.Preview", fallback: "Preview")
    /// Save
    internal static let save = L10n.tr("Localizable", "Common.Save", fallback: "Save")
  }
  internal enum Pin {
    /// Enter Passcode
    internal static let enterPasscode = L10n.tr("Localizable", "Pin.EnterPasscode", fallback: "Enter Passcode")
    /// Use Face ID
    internal static let useFaceId = L10n.tr("Localizable", "Pin.UseFaceId", fallback: "Use Face ID")
  }
  internal enum Splash {
    /// Your Security. Your Freedom
    internal static let description = L10n.tr("Localizable", "Splash.Description", fallback: "Your Security. Your Freedom")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
