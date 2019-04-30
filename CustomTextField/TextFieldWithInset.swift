//
//  TextFieldWithInset.swift
//  CustomTextField
//
//  Created by NHNEnt on 19/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class TextFieldWithInset: UITextField {
    
    var inset: UIEdgeInsets = UIEdgeInsets.zero
    var maxLength: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: inset.top, left: inset.left, bottom: inset.bottom, right: inset.right))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: inset.top, left: inset.left, bottom: inset.bottom, right: inset.right))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: inset.top, left: inset.left, bottom: inset.bottom, right: inset.right))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if maxLength > 0 {
            if let text = self.text {
                if  text.count > maxLength {
                    self.text = String(text[..<String.Index(encodedOffset: maxLength)])
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    
}
