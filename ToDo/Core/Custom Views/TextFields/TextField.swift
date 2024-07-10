//
//  TextField.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

class TextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlaceHolderText(placeHolder: String) {
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: Colors.theme.secondaryTextColor, NSAttributedString.Key.font: Fonts.regularCaption!])
    }
    
    private func configure() {
        layer.cornerRadius = 10
        
        textColor = Colors.theme.textColor
        tintColor = Colors.theme.textColor
        backgroundColor = Colors.theme.secondaryBgColor

        textAlignment = .left
        font = Fonts.regularCaption
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        autocorrectionType = .no
        returnKeyType = .done
        
        updateBorderColor()
    }
    
    func updateBorderColor() {
        let color = isEditing ? Colors.theme.textColor.cgColor : UIColor.clear.cgColor
        let borderWidth = isEditing ? 1.0 : 0.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layer.borderColor = color
            self?.layer.borderWidth = borderWidth
        }
    }
}

// MARK: Adding padding

extension TextField {
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

// MARK: Add date selection

extension TextField {
    func datePicker<T>(target: T, doneAction: Selector, cancelAction: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            barButtonItem.tintColor = Colors.theme.textColor
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.backgroundColor = Colors.theme.primaryColor
        datePicker.tintColor = Colors.theme.textColor
        self.inputView = datePicker
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
    
    func datePicketSetDate(date: Date) {
        if let datePicker = self.inputView as? UIDatePicker {
            datePicker.setDate(date, animated: true)
        }
    }
    
}
