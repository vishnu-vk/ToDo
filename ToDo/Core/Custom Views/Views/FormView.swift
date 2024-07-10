//
//  FormView.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit

protocol FormViewDelegate: AnyObject {
    func attachBtnClicked() -> Void
    func titleFieldUpdated(_ title: String?)
    func descriptionFieldUpdated(_ description: String?)
    func startDateUpdated(_ dateStr: String?)
    func endDateUpdated(_ dateStr: String?)
    func priorityUpdated(_ priority: Priority?)
}

class FormView: UIStackView {

    private let titleLabel = Label(type: .body)
    private let titleField = TextField()
    
    private let descriptionLabel = Label(type: .body)
    private let descriptionField = TextView()
    
    private let startDateLabel = Label(type: .body)
    private let startDayField = TextField()

    private let endDateLabel = Label(type: .body)
    private let endDayField = TextField()
    
    private let priorityLabel = Label(type: .body)
    private let priorityField = DropDown()
    
    private let attackBtn = Button()
    
    private let attachedImgView = UIImageView()
    
    weak var delegate: FormViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        spacing = 10
        alignment = .fill
        distribution = .fill
        layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        isLayoutMarginsRelativeArrangement = true
        
        addArrangedSubview(createTitleSection())
        addArrangedSubview(createDescriptionSection())
        addArrangedSubview(createStartDateSection())
        addArrangedSubview(createPrioritySection())
        addArrangedSubview(attackBtn)
        addArrangedSubview(attachedImgView)
        createAttachSection()
        createAttachedImageSection()
    }
    

    private func createTitleSection() -> UIStackView {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Task title"
        titleLabel.font = Fonts.boldCaption
        
        titleField.setPlaceHolderText(placeHolder: "Type task title")
        titleField.delegate = self
        
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(titleField)
        
        titleField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return view
    }
    
    private func createDescriptionSection() -> UIStackView {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = "Description"
        descriptionLabel.font = Fonts.boldCaption
        
        descriptionField.setPlaceHolderText(placeHolder: "Type task description")
        descriptionField.delegate = self
        
        view.addArrangedSubview(descriptionLabel)
        view.addArrangedSubview(descriptionField)
        
        descriptionField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return view
    }
    
    private func createStartDateSection() -> UIStackView {
    
        let startView = UIStackView()
        startView.axis = .vertical
        startView.spacing = 7
        startView.translatesAutoresizingMaskIntoConstraints = false
               
        startDateLabel.text = "Start Date"
        startDateLabel.font = Fonts.boldCaption
        
        startDayField.setPlaceHolderText(placeHolder: "Task start date")
        startDayField.delegate = self
        startDayField.datePicker(target: self,
                                  doneAction: #selector(startDoneAction),
                                  cancelAction: #selector(startCancelAction))
        
        
        startView.addArrangedSubview(startDateLabel)
        startView.addArrangedSubview(startDayField)
        
        startDayField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let endView = UIStackView()
        endView.axis = .vertical
        endView.spacing = 7
        endView.translatesAutoresizingMaskIntoConstraints = false
               
        endDateLabel.text = "End Date"
        endDateLabel.font = Fonts.boldCaption
        
        endDayField.setPlaceHolderText(placeHolder: "Task end date")
        endDayField.delegate = self
        endDayField.datePicker(target: self,
                                  doneAction: #selector(endDoneAction),
                                  cancelAction: #selector(endCancelAction))
        
        
        endView.addArrangedSubview(endDateLabel)
        endView.addArrangedSubview(endDayField)

        endDayField.heightAnchor.constraint(equalToConstant: 45).isActive = true

        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 7
        view.alignment = .fill
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addArrangedSubview(startView)
        view.addArrangedSubview(endView)
        
        return view
    }
    
    private func createPrioritySection() -> UIStackView {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        
        priorityLabel.text = "Priority"
        priorityLabel.font = Fonts.boldCaption
        
        priorityField.setTitle(title: "Select task priority")
        priorityField.dataSource = self
        priorityField.delegate = self
        priorityField.setAttachTitle(false)
        priorityField.setAddNoneOption(false)
        
        view.addArrangedSubview(priorityLabel)
        view.addArrangedSubview(priorityField)
        
        priorityField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return view
    }

    private func createAttachSection() {
        attackBtn.setTitle("Attach", for: .normal)
        attackBtn.setImage(UIImage(systemName: "paperclip"), for: .normal)
        attackBtn.titleLabel?.font = Fonts.boldCaption
        attackBtn.backgroundColor = Colors.theme.secondaryBgColor
        attackBtn.setTitleColor(Colors.theme.secondaryTextColor, for: .normal)
        attackBtn.tintColor = Colors.theme.secondaryTextColor
        attackBtn.addTarget(self, action: #selector(attachBtnClicked), for: .touchUpInside)
        
        attackBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func createAttachedImageSection() {
        attachedImgView.translatesAutoresizingMaskIntoConstraints = false
        attachedImgView.contentMode = .scaleAspectFill
        attachedImgView.layer.cornerRadius = 10
        attachedImgView.clipsToBounds = true
        attachedImgView.layer.masksToBounds = true
        attachedImgView.isHidden = true
    
        attachedImgView.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
    }
    
    func setAttachedImage(_ image: UIImage) {
        attachedImgView.image = image
        attachedImgView.isHidden = false
    }
    
    func releaseAllResponders() {
        titleField.resignFirstResponder()
        descriptionField.resignFirstResponder()
        startDayField.resignFirstResponder()
        endDayField.resignFirstResponder()
    }
    
    func loadWithData(task: Task) {
        titleField.text = task.title
        descriptionField.text = task.taskDescription
        descriptionField.setPlaceHolderHiddedn(!task.taskDescription.isEmpty)
        startDayField.datePicketSetDate(date: task.startDate)
        startDoneAction()
        endDayField.datePicketSetDate(date: task.endDate)
        endDoneAction()
        priorityField.defaultValue(index: task.priority.indexOf()!)
    }
    
}

// MARK: UITextFieldDelegates

extension FormView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textField = textField as? TextField {
            if let _ = textField.inputView as? UIDatePicker {
                if string.isEmpty {
                    return true
                }
                
                let allowedCharacterSet = CharacterSet(charactersIn: "0123456789/")
                if string.rangeOfCharacter(from: allowedCharacterSet.inverted) != nil {
                    return false
                }
                
                let currentText = textField.text ?? ""
                let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
                
                return prospectiveText.count <= 10
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TextField {
            textField.updateBorderColor()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TextField {
            textField.updateBorderColor()
            
            if let _ = textField.inputView as? UIDatePicker {
                if(textField == startDayField) {
                    delegate?.startDateUpdated(textField.text)
                } else if(textField == endDayField) {
                    delegate?.endDateUpdated(textField.text)
                }
            } else {
                if(textField == titleField) {
                    delegate?.titleFieldUpdated(textField.text ?? "")
                }
            }
        }
    }

    
    
}

extension FormView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let textView = textView as? TextView {
            textView.isActive = true
            textView.updateBorderColor()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let textView = textView as? TextView {
            textView.isActive = false
            textView.updateBorderColor()
            if (textView == descriptionField) {
                delegate?.descriptionFieldUpdated(textView.text)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let textView = textView as? TextView {
            textView.setPlaceHolderHiddedn(!textView.text.isEmpty)
        }
    }
}

// MARK: Drop Down Delegate

extension FormView: DropDownDataSource, DropDownDelegate {
    
    func numberOfOptions(in dropDown: DropDown) -> Int {
        return Priority.allCases.count
    }
    
    func dropDown(_ dropDown: DropDown, titleForOptionAt index: Int) -> String {
        return Priority.allCases[index].rawValue.capitalized
    }
    
    func didOptionSelected(_ dropDown: DropDown, index: Int) {
        delegate?.priorityUpdated(Priority.allCases[index])
    }
}

// MARK: Date Picker Events

extension FormView {
    @objc func startCancelAction() {
        startDayField.resignFirstResponder()
    }

    @objc func startDoneAction() {
        if let datePickerView = startDayField.inputView as? UIDatePicker {
            let dateString = datePickerView.date.getStringFromDate()
            startDayField.text = dateString
            
            startDayField.resignFirstResponder()
        }
    }
    
    @objc func endCancelAction() {
        endDayField.resignFirstResponder()
    }

    @objc func endDoneAction() {
        if let datePickerView = endDayField.inputView as? UIDatePicker {
            let dateString = datePickerView.date.getStringFromDate()
            endDayField.text = dateString
            
            endDayField.resignFirstResponder()
        }
    }
}


// MARK: Attach Button Event

extension FormView {
    @objc func attachBtnClicked() {
        attackBtn.animate()
        delegate?.attachBtnClicked()
    }
}

// MARK: Fix for the border color when toggling the theme

extension FormView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               titleField.updateBorderColor()
               descriptionField.updateBorderColor()
               startDayField.updateBorderColor()
           }
       }
    }
}
