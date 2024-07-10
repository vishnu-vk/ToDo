//
//  NumberBoxView.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

class NumberBoxView: UIView {
    private let line1 = UIView()
    private let line2 = UIView()
    private let line3 = UIView()
    let number = Tag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints =  false
        configure()
    }
    
    private func configure() {
        addSubview(number)
        addSubview(line1)
        addSubview(line2)
        addSubview(line3)
        
        line1.translatesAutoresizingMaskIntoConstraints = false
        line2.translatesAutoresizingMaskIntoConstraints = false
        line3.translatesAutoresizingMaskIntoConstraints = false
        
        number.layer.cornerRadius = 10
        number.backgroundColor = Colors.theme.textColor
        number.label.textColor = Colors.theme.primaryColor
        
        
        NSLayoutConstraint.activate([
            line1.topAnchor.constraint(equalTo: self.topAnchor),
            line1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            line1.widthAnchor.constraint(equalToConstant: 1),
            line1.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5, constant: -15),
            
            number.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            number.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            number.heightAnchor.constraint(equalToConstant: 30),
            number.widthAnchor.constraint(equalToConstant: 30),
            
            line2.topAnchor.constraint(equalTo: number.bottomAnchor),
            line2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            line2.widthAnchor.constraint(equalToConstant: 1),
            line2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            line3.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            line3.leadingAnchor.constraint(equalTo: number.trailingAnchor),
            line3.heightAnchor.constraint(equalToConstant: 1),
            line3.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setSelected(_ selected: Bool) {
        let color = selected ? Colors.theme.textColor : Colors.theme.secondaryColor
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.line1.backgroundColor = color
            self?.line2.backgroundColor = color
            self?.line3.backgroundColor = color
        }
    }
    
}
