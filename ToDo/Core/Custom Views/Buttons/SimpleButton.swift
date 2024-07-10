//
//  SimpleButton.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit

class SimpleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    private func configure() {
        backgroundColor = Colors.theme.primaryColor
        setTitleColor(Colors.theme.textColor, for: .normal)
        titleLabel?.font = Fonts.body
        
        layer.cornerRadius = 10
    }
    
    func invertedColor() {
        backgroundColor = Colors.theme.textColor
        setTitleColor(Colors.theme.primaryColor, for: .normal)
    }
    
    func animate() {
        UIView.animate(withDuration: 0.1,
            animations: {
                self.layer.opacity = 0.5
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.layer.opacity = 1.0
            }
        })
    }
    
}
