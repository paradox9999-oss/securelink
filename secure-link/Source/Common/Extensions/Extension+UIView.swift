//
//  Extension+UIStackView.swift
//  dating-app
//
//  Created by Александр on 27.03.2025.
//

import UIKit

extension UIView {
    
    func hideAnimated(in stackView: UIStackView) {
        if !self.isHidden {
            UIView.animate(
                withDuration: 0.55,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = true
                    stackView.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
    
    func showAnimated(in stackView: UIStackView) {
        if self.isHidden {
            UIView.animate(
                withDuration: 0.55,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = false
                    stackView.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
    
    func showAnimate(in stackView: UIStackView) {
        self.alpha = 0
        self.isHidden = false
        
        stackView.layoutIfNeeded()
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: [],
            animations: {
                self.alpha = 1
                stackView.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    func hideAnimate(in stackView: UIStackView, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            animations: {
                self.alpha = 0
                stackView.layoutIfNeeded()
            },
            completion: { _ in
                self.isHidden = true
                completion?()
            }
        )
    }
    
}

extension UIView {
    
    func rounded(radius: CGFloat? = nil) {
        self.layer.masksToBounds = true
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
    
    func bordered(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func unbordered() {
        self.layer.borderWidth = 0
    }
    
}

extension UIView {
    
    struct Shadow {
        var color: UIColor
        var opacity: Float
        var offset: CGSize
        var radius: CGFloat
        var cornerRadius: CGFloat?
        var path: Bool?
    }
    
    func dropShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4,
        cornerRadius: CGFloat? = nil,
        shadowPath: Bool = true
    ) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
        if shadowPath {
            self.layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: self.layer.cornerRadius
            ).cgPath
        }
    }
    
    func dropShadow(_ shadow: Shadow) {
        self.dropShadow(
            color: shadow.color,
            opacity: shadow.opacity,
            offset: shadow.offset,
            radius: shadow.radius,
            cornerRadius: shadow.cornerRadius,
            shadowPath: shadow.path ?? true
        )
    }
    
}

extension UIView {
    func superview<T: UIView>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: type)
    }
}
