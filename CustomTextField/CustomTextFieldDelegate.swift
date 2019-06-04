//
//  CustomTextFieldDelegate.swift
//  CustomTextField
//
//  Created by NHNEnt on 04/06/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

@objc public protocol CustomTextFieldDelegate: class {
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}
