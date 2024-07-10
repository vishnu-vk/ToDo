//
//  Tag.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

class Tag: UIView {
    
    let label = Label(type: .caption)

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
        addSubview(label)
        label.textAlignment = .center
        label.font = Fonts.regularFootnote
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
        ])
    }
    
    func setTagName(name: String) {
        label.text = name
    }
}
