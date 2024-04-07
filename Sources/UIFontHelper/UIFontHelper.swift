// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

extension UIFont {
    public static var largeTitle: UIFont { return UIFont.preferredFont(forTextStyle: .largeTitle) }
    public static var title: UIFont { return UIFont.preferredFont(forTextStyle: .title1) }
    public static var title2: UIFont { return UIFont.preferredFont(forTextStyle: .title2) }
    public static var title3: UIFont { return UIFont.preferredFont(forTextStyle: .title3) }
    public static var headline: UIFont { return UIFont.preferredFont(forTextStyle: .headline) }
    public static var subheadline: UIFont { return UIFont.preferredFont(forTextStyle: .subheadline) }
    public static var body: UIFont { return UIFont.preferredFont(forTextStyle: .body) }
    public static var callout: UIFont { return UIFont.preferredFont(forTextStyle: .callout) }
    public static var caption: UIFont { return UIFont.preferredFont(forTextStyle: .caption1) }
    public static var caption2: UIFont { return UIFont.preferredFont(forTextStyle: .caption2) }
    public static var footnote: UIFont { return UIFont.preferredFont(forTextStyle: .footnote) }


    private func addingAttributes(_ attributes: [UIFontDescriptor.AttributeName: Any]) -> UIFont {
        let font = UIFont(descriptor: fontDescriptor.addingAttributes(attributes), size: pointSize)
        return font
    }

    // MARK: Getting System Fonts

    /// Gets a system font with the given style and design
    public static func system(_ style: UIFont.TextStyle, design: UIFontDescriptor.SystemDesign = .default) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style).withDesign(design)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    /// Specifies a system font to use, along with the style, weight, and any design parameters you want applied to the text.
    public static func system(size: CGFloat, weight: UIFont.Weight = .regular, design: UIFontDescriptor.SystemDesign = .default) -> UIFont {
        let font = UIFont.systemFont(ofSize: size).weight(weight)
        let descriptor = font.fontDescriptor.withDesign(design)
        return UIFont(descriptor: descriptor!, size: size)
    }

    // MARK: Creating Custom Fonts

    /// Create a custom font with the given name and a fixed size that does not scale with Dynamic Type.
    public static func custom(_ name: String, fixedSize: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: fixedSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fixedSize)
    }

    ///    Create a custom font with the given name and size that scales relative to the given textStyle.
    public static func custom(_ name: String, size: CGFloat, relativeTo: UIFont.TextStyle) -> UIFont {
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        return UIFontMetrics(forTextStyle: relativeTo).scaledFont(for: font)
    }

    ///  Create a custom font with the given name and size that scales with the body text style.
    public static func custom(_ name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }

    // MARK: Styling a Font

    public func weight(_ weight: UIFont.Weight) -> UIFont {
        let newDescriptor = fontDescriptor.addingAttributes([.traits:
                                                                [UIFontDescriptor.TraitKey.weight: weight.rawValue]
                                                            ])
        return UIFont(descriptor: newDescriptor, size: pointSize)
    }

    public func bold() -> UIFont {
        return self.weight(.bold)
    }

    public func italic() -> UIFont {
        let traits = fontDescriptor.symbolicTraits.union(.traitItalic)
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    public func monospaced() -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(.traitMonoSpace)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    public func monospacedDigit() -> UIFont {
        let fontFeatures = [
            [
                UIFontDescriptor.FeatureKey.type: kNumberSpacingType,
                UIFontDescriptor.FeatureKey.selector: kMonospacedNumbersSelector
            ]
        ]
        let descriptorWithFeatures = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings: fontFeatures])
        return UIFont(descriptor: descriptorWithFeatures, size: 0)
    }

    public func smallCaps() -> UIFont {
        return self.lowercaseSmallCaps().uppercaseSmallCaps()
    }

    public func lowercaseSmallCaps() -> UIFont {
        let fontFeatures = [
            [
                UIFontDescriptor.FeatureKey.type: kLowerCaseType,
                UIFontDescriptor.FeatureKey.selector: kLowerCaseSmallCapsSelector
            ]
        ]
        let descriptorWithFeatures = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings: fontFeatures])
        return UIFont(descriptor: descriptorWithFeatures, size: 0)
    }

    public func uppercaseSmallCaps() -> UIFont {
        let fontFeatures = [
            [
                UIFontDescriptor.FeatureKey.type: kUpperCaseType,
                UIFontDescriptor.FeatureKey.selector: kUpperCaseSmallCapsSelector
            ]
        ]
        let descriptorWithFeatures = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings: fontFeatures])
        return UIFont(descriptor: descriptorWithFeatures, size: 0)
    }
}
