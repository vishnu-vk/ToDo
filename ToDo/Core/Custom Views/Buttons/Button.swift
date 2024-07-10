//
//  Button.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints =  false
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(Colors.theme.primaryColor, for: .normal)
        titleLabel?.font = Fonts.buttonRegular
        backgroundColor = Colors.theme.textColor
        tintColor = Colors.theme.primaryColor
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        adjustsImageWhenHighlighted = false
    }
    
    func inverteColor() {
        backgroundColor = Colors.theme.primaryColor
        tintColor = Colors.theme.textColor
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
