//
//  FilterView.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func sortOptionChanged(sortOption: SortOptions?) -> Void
}

class FilterView: UIView {
    
    weak var delegate: FilterViewDelegate?
    
    let filterIcon = Button()
    let dropDown = DropDown()

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
        addSubview(filterIcon)
        addSubview(dropDown)
        
        filterIcon.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        filterIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        filterIcon.addTarget(self, action: #selector(filterIconPressed), for: .touchUpInside)
        filterIcon.inverteColor()
        
        dropDown.setTitle(title: "Sort by")
        dropDown.dataSource = self
        dropDown.delegate = self
        
        NSLayoutConstraint.activate([
            
            filterIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            filterIcon.widthAnchor.constraint(equalTo: self.heightAnchor),
            filterIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            filterIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            dropDown.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            dropDown.widthAnchor.constraint(equalToConstant: 180),
            dropDown.leadingAnchor.constraint(equalTo: filterIcon.trailingAnchor, constant: 10),
            dropDown.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

        ])
    }
    
    
}

extension FilterView {
    @objc private func filterIconPressed(sender: UIButton) {
        if let button = sender as? Button {
            button.animate()
        }
    }
}


extension FilterView: DropDownDataSource, DropDownDelegate {
    
    func numberOfOptions(in dropDown: DropDown) -> Int {
        return SortOptions.allCases.count
    }
    
    func dropDown(_ dropDown: DropDown, titleForOptionAt index: Int) -> String {
        let option = SortOptions.allCases[index]
        switch(option) {
            case .name: return "name"
            case .startDate: return "start date"
            case .endDate: return "end date"
            case .priority: return "priority"
        }
    }
    
    func didOptionSelected(_ dropDown: DropDown, index: Int) {
        let sortOption = index >= 0 ? SortOptions(rawValue: index) : nil
        delegate?.sortOptionChanged(sortOption: sortOption)
    }
    
}
