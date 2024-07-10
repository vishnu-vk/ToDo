//
//  DropDown.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit

protocol DropDownDataSource: AnyObject {
    func numberOfOptions(in dropDown: DropDown) -> Int
    func dropDown(_ dropDown: DropDown, titleForOptionAt index: Int) -> String
}

protocol DropDownDelegate: AnyObject {
    func didOptionSelected(_ dropDown: DropDown, index: Int) -> Void
}

class DropDown: UIView {

    private var customMenu: UIMenu!
    private var title: String = ""
    private let textBtn = Button()
    private let arrBtn = Button()
    
    private var addNoneOption: Bool = true
    private var attachTitle: Bool = true
    private var selectedOption: Int?
    
    private var isActive: Bool = false
    
    weak var delegate: DropDownDelegate?
    weak var dataSource: DropDownDataSource? {
        didSet {
            setUpMenu()
        }
    }
    
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
        addSubview(textBtn)
        addSubview(arrBtn)
        
        backgroundColor = Colors.theme.secondaryBgColor
        layer.cornerRadius = 10
        
        arrBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        arrBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        arrBtn.backgroundColor = .clear
        arrBtn.contentHorizontalAlignment = .right
        arrBtn.imageView?.contentMode = .scaleAspectFit
        arrBtn.tintColor = Colors.theme.secondaryTextColor
        
        textBtn.backgroundColor = .clear
        textBtn.setTitleColor(Colors.theme.secondaryTextColor, for: .normal)
        textBtn.contentHorizontalAlignment = .left
        textBtn.titleLabel?.font = Fonts.regularCaption
        textBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        textBtn.addTarget(self, action: #selector(menuVisibilityChanged(_:)), for: .menuActionTriggered)
        arrBtn.addTarget(self, action: #selector(menuVisibilityChanged(_:)), for: .menuActionTriggered)

        
        NSLayoutConstraint.activate([
            arrBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            arrBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            arrBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            arrBtn.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0, constant: -14),
            
            textBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            textBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            textBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            textBtn.trailingAnchor.constraint(equalTo: arrBtn.leadingAnchor, constant: -7)
        ])
    }
    
    @objc private func menuVisibilityChanged(_ sender: UIButton) {
        isActive = true
        updateBorderColor()
    }
    @objc private func menuVisibilityChanged2() {
        isActive = false
        updateBorderColor()
    }
    
    private func setUpMenu() {
        guard let dataSource = dataSource else { return }
                
        var actions: [UIAction] = []
        let numberOfOptions = dataSource.numberOfOptions(in: self)
        
        if(addNoneOption) {
            let action = UIAction(title: "None", image: nil) { [weak self] _ in
                self?.clearSelection()
            }
            actions.append(action)
        }
        
        for index in 0..<numberOfOptions {
            let optionTitle = dataSource.dropDown(self, titleForOptionAt: index)
            let action = UIAction(title: optionTitle.capitalized, image: nil) { [weak self] _ in
                self?.setSelected(index: index)
                self?.updateSelectionValue(text: optionTitle, with: index)
            }
            actions.append(action)
        }
        
        customMenu = UIMenu(title: "", children: actions)
        
        textBtn.menu = customMenu
        textBtn.showsMenuAsPrimaryAction = true
        
        arrBtn.menu = customMenu
        arrBtn.showsMenuAsPrimaryAction = true
    }
    
    func setTitle(title: String) {
        self.title = title
        updatedTitle(self.title)
    }
    
    func updateSelectionValue(text: String, with Index: Int) {
        let title = attachTitle ? "\(title) \(text)" : text
        updatedTitle(title)
        isActive = false
        updateBorderColor()
        textBtn.setTitleColor(Colors.theme.textColor, for: .normal)
        delegate?.didOptionSelected(self, index: Index)
    }
    
    func setAddNoneOption(_ option: Bool) {
        addNoneOption = option
        setUpMenu()
    }
    
    func setAttachTitle(_ attachTitle: Bool){
        self.attachTitle = attachTitle
    }
    
    func getSelected() -> Int? {
        return selectedOption
    }
    
    private func updatedTitle(_ text: String) {
        textBtn.setTitle(text, for: .normal)
    }
    
    private func clearSelection() {
        updatedTitle(title)
        isActive = false
        updateBorderColor()
        textBtn.setTitleColor(Colors.theme.secondaryTextColor, for: .normal)
        delegate?.didOptionSelected(self, index: -1)
    }
    
    private func setSelected(index: Int) {
        selectedOption = index
    }
    
    func updateBorderColor() {
        let color = isActive ? Colors.theme.textColor.cgColor : UIColor.clear.cgColor
        let borderWidth = isActive ? 1.0 : 0.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layer.borderColor = color
            self?.layer.borderWidth = borderWidth
        }
    }
    
    func defaultValue(index: Int) {
        setSelected(index: index)
        let text = dataSource?.dropDown(self, titleForOptionAt: index) ?? ""
        let title = attachTitle ? "\(title) \(text)" : text
        updatedTitle(title)
        textBtn.setTitleColor(Colors.theme.textColor, for: .normal)
    }
    
}
