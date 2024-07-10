//
//  Label.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

enum LabelType {
    case body, heading, heading2, heading3, caption, footnote
}

class Label: UILabel {

    private var labelType: LabelType = .body

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: LabelType) {
        super.init(frame: .zero)
        labelType = type
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    private func configure() {
        textColor = Colors.theme.textColor
        textAlignment = .left
        backgroundColor = .clear
        numberOfLines = 1
        setFont()
    }
    
    private func setFont() {
        switch(labelType) {
            case .body:
                font = Fonts.body
            case .caption:
                font = Fonts.caption
            case .heading:
                font = Fonts.primaryHeading
            case .heading2:
                font = Fonts.secondaryHeading
            case .heading3:
                font = Fonts.tertiaryHeading
            case .footnote:
                font = Fonts.footnote
        }
    }
    
    func invertColor() {
        textColor = Colors.theme.primaryColor
    }

}
