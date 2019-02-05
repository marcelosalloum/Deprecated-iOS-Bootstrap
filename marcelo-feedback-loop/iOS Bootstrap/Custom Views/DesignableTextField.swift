//
//  DesignableTextField.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

public protocol DesignableTextFieldDelegate {
    func deleteKeyPressed(sender: DesignableTextField)
}

@IBDesignable
open class DesignableTextField: UITextField {

    public var designableDelegate: DesignableTextFieldDelegate? = nil

    // MARK: - Shapes
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 10 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }

    // MARK: - TextField

    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.mainColor()
    }

    @IBInspectable var placeholderColor: UIColor = UIColor.white {
        didSet {
            if let placeholder = placeholder {
                let attributes = [NSAttributedString.Key.foregroundColor: placeholderColor]
                attributedPlaceholder = NSAttributedString(string: placeholder,
                                                           attributes: attributes)
            }
        }
    }

    @IBInspectable var placeholderSpacing: CGFloat = 0 {
        didSet {
            if let placeholder = placeholder {
                let attributes = [NSAttributedString.Key.kern: placeholderSpacing]
                attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            }
        }
    }

    // Detect delete key
    override open func deleteBackward() {
        super.deleteBackward()
        self.designableDelegate?.deleteKeyPressed(sender: self)
    }
}
