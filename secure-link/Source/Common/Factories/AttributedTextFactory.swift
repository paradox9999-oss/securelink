//
//  AttributedTextFactory.swift
//  dating-app
//
//  Created by Александр on 17.06.2025.
//

import Foundation
import UIKit

struct AttributedTextFactory {
        
    static func attributed(string: String, font: UIFont, colors: [UIColor]) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: string)
        let range = NSRange(location: 0, length: (string as NSString).length)

        let gradientAttributes: [NSAttributedString.Key: Any] = [.font: font]
        let gradientSize = (string as NSString).size(withAttributes: gradientAttributes)
        let gradientImage = UIImage.gradientImage(
            size: CGSize(width: gradientSize.width, height: 200),
            colors: colors
        )
        let gradientColor = UIColor(patternImage: gradientImage)

        attributedText.addAttributes(
            [.font: font,
             .foregroundColor: gradientColor],
            range: range
        )
        return attributedText
    }
    
}
