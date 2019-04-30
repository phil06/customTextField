//
//  CustomTextField.swift
//  CustomTextField
//
//  Created by NHNEnt on 19/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

public class CustomTextField: UIView {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textfield: TextFieldWithInset!
    @IBOutlet weak var additionalImage: UIImageView!
    
    private var contentView: UIView!
    private var contentViewConstraints: [NSLayoutConstraint]!
    private var iconImageInset: UIEdgeInsets!
    private var additionalIconTrailingInset: CGFloat!
    
    public var inputPickerView: UIPickerView!
    private var pickerList:[String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayout()
    }
    
    private func setAccessoryViewType(type: InputAccessoryViewType) {
        let view = InputAccessoryView(type: type)
        view.doneButton.target = self
        view.doneButton.action = #selector(accessoryViewDoneTapped)
        self.textfield.inputAccessoryView = view
    }
    
    @objc func accessoryViewDoneTapped() {
        self.textfield.resignFirstResponder()
        
        if inputPickerView != nil {
            self.textfield.text = pickerList[inputPickerView.selectedRow(inComponent: 0)]
        }
    }
    
    private func initLayout() {
        let nibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        
        self.iconImageInset = UIEdgeInsets.zero
        self.textfield.delegate = self
    }
    
    public func setTextFieldLayout(inset: UIEdgeInsets, maxInput: Int,
                                   useAccessoryView: InputAccessoryViewType = .End, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        self.textfield.inset = inset
        self.textfield.maxLength = maxInput
        self.textfield.font = font
        
        if useAccessoryView != .End {
            self.setAccessoryViewType(type: useAccessoryView)
        }
        
        self.textfield.sizeToFit()
        
        setNeedsLayout()
        
        setAutoLayout()
    }
    
    public func setIconLayout(img: UIImage, inset: UIEdgeInsets) {
        self.iconImage.image = img
        self.iconImageInset = inset
        self.iconImage.sizeToFit()
        
        setNeedsLayout()
        
        setAutoLayout()
    }
    
    public func setKeyboardType(type: UIKeyboardType) {
        self.textfield.keyboardType = type
    }
    
    public func setClearButton(mode: UITextField.ViewMode) {
        self.textfield.clearButtonMode = mode
    }
    
    public func setSecureTextEntry(val: Bool) {
        self.textfield.isSecureTextEntry = val
    }
    
    public func setPlaceholder(txt: String) {
        self.textfield.placeholder = txt
    }
    
    public func setFontColor(color: UIColor) {
        self.textfield.textColor = color
    }
    
    public func setTextFieldLine(edge: [UIRectEdge], color: UIColor, thickness: CGFloat) {
        for side in edge {
            
            let border = UIView()
            border.backgroundColor = color
            addSubview(border)
            border.translatesAutoresizingMaskIntoConstraints = false
            
            switch side {
            case UIRectEdge.top:
                border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
                border.leftAnchor.constraint(equalTo: textfield.leftAnchor).isActive = true
                border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                break
            case UIRectEdge.bottom:
                border.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -thickness).isActive = true
                border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
                border.leftAnchor.constraint(equalTo: textfield.leftAnchor).isActive = true
                border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                break
            case UIRectEdge.left:
                border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                border.leftAnchor.constraint(equalTo: textfield.leftAnchor, constant: -thickness).isActive = true
                border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
                break
            case UIRectEdge.right:
                border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                border.leftAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
                break
            default:
                break
            }
        }
    }
    
    
    public func usePickerView(listTitle: [String]) {
        inputPickerView = UIPickerView()
        inputPickerView.showsSelectionIndicator = true
        self.textfield.inputView = inputPickerView
        inputPickerView.delegate = self
        inputPickerView.dataSource = self
        
        pickerList = listTitle
        
        setNeedsLayout()
        setAutoLayout()
    }
    
    public func setAdditionalIcon(img: UIImage, trailingInset: CGFloat) {
        self.additionalImage.image = img
        self.additionalIconTrailingInset = trailingInset
        self.additionalImage.sizeToFit()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(activateTextField))
        self.additionalImage.isUserInteractionEnabled = true
        self.additionalImage.addGestureRecognizer(gesture)
        
        setNeedsLayout()
        setAutoLayout()
    }
    
    @objc private func activateTextField() {
        textfield.becomeFirstResponder()
    }
    
    public func setText(txt: String) {
        self.textfield.text = txt
    }
    
    public func getText() -> String? {
        return self.textfield.text
    }

    private func setAutoLayout() {
        let imgHeight = self.iconImage.image != nil ? self.iconImage.bounds.size.height + self.iconImageInset.top + self.iconImageInset.bottom : 0
        let imgWidth = self.iconImage.image != nil ? self.iconImage.bounds.size.width : 0
        let txtSize = self.textfield.bounds.size
        let additionalImgSizeWidth = self.additionalImage.image != nil ? self.additionalImage.bounds.size.width : 0
        
        let contentHeight = imgHeight > txtSize.height ? imgHeight : txtSize.height
        
        let metrics = [
            "imgW": imgWidth,
            "contentH": contentHeight,
            "imgInsetTop": self.iconImageInset.top,
            "imgInsetLeft": self.iconImageInset.left,
            "imgInsetBottom": self.iconImageInset.bottom,
            "imgInsetRight": self.iconImageInset.right,
            "additionalImageW": additionalImgSizeWidth,
            "additionalImageInset": additionalImgSizeWidth > 0 ? additionalIconTrailingInset : 0
        ]

        if let constraints = self.contentViewConstraints {
            NSLayoutConstraint.deactivate(constraints)
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        additionalImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentViewConstraints =
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-imgInsetLeft-[iconImage(imgW)]-imgInsetRight-[textfield]-0-[additionalImage(additionalImageW)]-additionalImageInset-|", options: .alignAllCenterY, metrics: metrics, views: ["iconImage": iconImage, "textfield": textfield, "additionalImage": additionalImage]) +
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-imgInsetTop-[iconImage]-imgInsetBottom-|", metrics: metrics, views: ["iconImage": iconImage]) +
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[contentView(contentH)]-0-|", metrics: metrics, views: ["contentView": contentView]) +
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[contentView]-0-|", metrics: metrics, views: ["contentView": contentView])
        NSLayoutConstraint.activate(contentViewConstraints)
        
        updateConstraints()
    }

}

extension CustomTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerList.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerList[row]
    }
    
}

extension CustomTextField: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let field = textfield as TextFieldWithInset
        field.textFieldDidEndEditing(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        accessoryViewDoneTapped()
        return true
    }

}
