//
//  ProgressView.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit

class ProgressView: UIView {
    
    let icon = UIImageView()
    let text = Label(type: .caption)

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
        addSubview(icon)
        addSubview(text)
        
        text.font = Fonts.regularFootnote
        icon.tintColor = Colors.theme.textColor
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            icon.widthAnchor.constraint(equalTo: self.heightAnchor),
            
            text.topAnchor.constraint(equalTo: self.topAnchor),
            text.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 7),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func setProgress(_ completed: Bool) {
        let image = completed ? UIImage(systemName: "record.circle") : UIImage(systemName: "circle")
        let label = completed ? "Completed" : "In progress"
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.icon.image = image
            self?.text.text = label
        }
    }

}
