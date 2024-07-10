//
//  EmptyView.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import Foundation
import UIKit

class EmptyView: UIView {
    
    private let label = Label(type: .body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(label)
        
        label.text = "No tasks to display. Please add new tasks."
        label.textColor = Colors.theme.secondaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.regularCaption
        
        backgroundColor = Colors.theme.secondaryBgColor
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
    }
    
    func setTitle(text: String) {
        label.text = text
    }
    
    func setAsHidden(isHidden: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.isHidden = isHidden
        }
    }
    
}
