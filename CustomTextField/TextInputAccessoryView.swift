//
//  TextInputAccessoryView.swift
//  CustomTextField
//
//  Created by NHNEnt on 19/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

public enum InputAccessoryViewType: Int {
    case Default = 0
    case NextPrevious = 1
    case End = 2
}

class InputAccessoryView: UIToolbar {
    
    var doneButton: UIBarButtonItem!
    var spaceButton: UIBarButtonItem!
    var previousButton: UIBarButtonItem!
    var nextButton: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type: InputAccessoryViewType) {
        self.init(frame: CGRect.zero)
        
        barStyle = .default
        isTranslucent = true
        sizeToFit()
        tintColor = UIColor.black
        
        doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneTapped))
        
        spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        previousButton = UIBarButtonItem(title: "〈", style: .plain, target: self, action: #selector(prevTapped))
        
        nextButton = UIBarButtonItem(title: "〉", style: .plain, target: self, action: #selector(nextTapped))
        
        switch type {
        case .Default:
            setItems([spaceButton, doneButton], animated: false)
            break
        case .NextPrevious:
            setItems([previousButton, nextButton, spaceButton, doneButton], animated: false)
            break
        default:
            break
        }
        
        isUserInteractionEnabled = true
    }
    
    @objc func doneTapped() {
        NotificationCenter.default.post(name: .CustomInputAccessoryDone, object: nil)
    }
    
    @objc func nextTapped() {
        NotificationCenter.default.post(name: .CustomInputAccessoryNext, object: nil)
    }
    
    @objc func prevTapped() {
        NotificationCenter.default.post(name: .CustomInputAccessoryPrev, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Notification.Name {
    //input accessory
    static let CustomInputAccessoryDone = Notification.Name("CustomInputAccessoryDone")
    static let CustomInputAccessoryNext = Notification.Name("CustomInputAccessoryNext")
    static let CustomInputAccessoryPrev = Notification.Name("CustomInputAccessoryPrev")
}
