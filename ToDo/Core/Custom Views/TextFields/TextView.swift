//
//  TextView.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit

class TextView: UITextView {

    var isActive: Bool = false
    
    private let padding = UIEdgeInsets(top: 7, left: 3, bottom: 7, right: 7)
    private let placeHolder = Label(type: .caption)
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlaceHolderText(placeHolder: String) {
        self.placeHolder.text = placeHolder
        self.placeHolder.font = Fonts.regularCaption
        self.placeHolder.textColor = Colors.theme.secondaryTextColor
        
        addSubview(self.placeHolder)
        
        NSLayoutConstraint.activate([
            self.placeHolder.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            self.placeHolder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            self.placeHolder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7)
        ])
    }
    
    func setPlaceHolderHiddedn(_ isHidden: Bool) {
        placeHolder.isHidden = isHidden
    }
    
    private func configure() {
        layer.cornerRadius = 10
        textContainerInset = padding
        textColor = Colors.theme.textColor
        tintColor = Colors.theme.textColor
        backgroundColor = Colors.theme.secondaryBgColor

        textAlignment = .left
        font = Fonts.regularCaption
        
        autocorrectionType = .no
        returnKeyType = .done
        
        updateBorderColor()
    }
    
    func updateBorderColor() {
        let color = isActive ? Colors.theme.textColor.cgColor : UIColor.clear.cgColor
        let borderWidth = isActive ? 1.0 : 0.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layer.borderColor = color
            self?.layer.borderWidth = borderWidth
        }
    }
}
