//
//  TableViewCell.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let stackView = UIStackView()
    let container = NumberBoxView()
    let footnoteContainer = UIStackView()
    
    let title = Label(type: .body)
    let priority = Tag()
    let note = Label(type: .caption)
    let date = Label(type: .body)
    let progress = ProgressView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        container.setSelected(selected)
    }
        
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        animateHighLight(highlighted)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(stackView)
        
        footnoteContainer.translatesAutoresizingMaskIntoConstraints = false
        footnoteContainer.axis = .horizontal
        footnoteContainer.alignment = .fill
        footnoteContainer.distribution = .equalSpacing
        footnoteContainer.addArrangedSubview(date)
        footnoteContainer.addArrangedSubview(progress)
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(priority)
        stackView.addArrangedSubview(note)
        stackView.addArrangedSubview(footnoteContainer)
        
        title.font = Fonts.boldBody
        note.numberOfLines = 0
        date.font = Fonts.regularFootnote
        

        stackView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            container.widthAnchor.constraint(equalToConstant: 50),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            footnoteContainer.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -20)
        ])
        
    }
    
    func setPriority(priority: Priority) {
        switch(priority){
            case .high:
                stackView.backgroundColor = Colors.theme.highPriorityColor
                self.priority.backgroundColor = Colors.theme.highPriorityDarkColor
            case .medium:
                stackView.backgroundColor = Colors.theme.mediumPriorityColor
                self.priority.backgroundColor = Colors.theme.mediumPriorityDarkColor
            case .normal:
                stackView.backgroundColor = Colors.theme.normalPriorityColor
                self.priority.backgroundColor = Colors.theme.normalPriorityDarkColor
            case .low:
                stackView.backgroundColor = Colors.theme.lowPriorityColor
                self.priority.backgroundColor = Colors.theme.lowPriorityDarkColor
        }
        self.priority.setTagName(name: priority.rawValue.capitalized) 
    }

    func setBoxNumber(number: Int) {
        container.number.setTagName(name: "\(number)")
    }
    
    func setProgress(_ progress: Bool) {
        self.progress.setProgress(progress)
    }
    
    private func animateHighLight(_ isHighLighted: Bool) {
        let opacity: Float = isHighLighted ? 0.5 : 1.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.stackView.layer.opacity = opacity
        }
    }
    
}
