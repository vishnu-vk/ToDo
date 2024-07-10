//
//  SearchView.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func search(searchText: String?) -> Void
}

class SearchView: UIView {
    
    let searchField = TextField()
    let searchButton = Button()
    
    weak var delegate: SearchViewDelegate?
    
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
        addSubview(searchField)
        addSubview(searchButton)
        
        searchField.setPlaceHolderText(placeHolder: "Enter task name")
        searchField.delegate = self
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            
            searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            searchField.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            searchField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
}

// MARK: UITextFieldDelegates

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchField.updateBorderColor()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        searchField.updateBorderColor()
        performSearch(with: textField.text)
    }

    @objc private func searchButtonPressed(sender: UIButton) {
        if let button = sender as? Button {
            button.animate()
        }
        searchField.resignFirstResponder()
        performSearch(with: searchField.text)
    }
    

    func performSearch(with searchText: String?) {
        delegate?.search(searchText: searchText)
    }
}

// MARK: Fix for the border color when toggling the theme

extension SearchView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               searchField.updateBorderColor()
           }
       }
    }
}
