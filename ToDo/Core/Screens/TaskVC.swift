//
//  TaskVC.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import UIKit
import UniformTypeIdentifiers

class TaskVC: BaseViewController {
    
    private let viewTitle: String
    private var isNew: Bool = true
    
    private let scrollView = UIScrollView()
    private let buttonContainer = UIView()
    private let taskButton = SimpleButton()
    private let formView = FormView()
    
    private let viewModel: TaskViewModel

    init(with task: Task) {
        viewModel = TaskViewModel(task: task)
        viewTitle = "Modify Task"
        isNew = false
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        viewModel = TaskViewModel(task: nil)
        viewTitle = "Create Task"
        isNew = true
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.theme.primaryColor
        
        addCustomSubViews()
        configureNavBar()
        setConstraints()
    }
    
    private func configureNavBar() {
        self.title = viewTitle
        navigationItem.largeTitleDisplayMode = .never
        
        let backButton = Button(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.inverteColor()
        backButton.backgroundColor = .clear
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    // MARK: Adding Sub Views
    
    private func addCustomSubViews() {
        addScrollView()
        addFormView()
        addTaskutton()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    private func addFormView() {
        scrollView.addSubview(formView)
        formView.delegate = self
        if(!isNew) {
            formView.loadWithData(task: viewModel.task)
            if let image = viewModel.taskAttachedImage {
                formView.setAttachedImage(image)
            }
        }
    }
    
    private func addTaskutton() {
        view.addSubview(buttonContainer)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        taskButton.setTitle(viewTitle, for: .normal)
        taskButton.invertedColor()
        taskButton.titleLabel?.font = Fonts.boldBody
        taskButton.translatesAutoresizingMaskIntoConstraints = false
        taskButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        
        buttonContainer.addSubview(taskButton)
    }
    
    // MARK: Constraints settings
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
            formView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            formView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            formView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            buttonContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            buttonContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            buttonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            buttonContainer.heightAnchor.constraint(equalToConstant: 70),
            
            taskButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 10),
            taskButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -10),
            taskButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: -10),
            taskButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 10),
        ])
    }
}

// MARK: User Events

extension TaskVC {
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Form Delegate

extension TaskVC: FormViewDelegate {
    func titleFieldUpdated(_ title: String?) {
        guard let title = title else { return }
        
        viewModel.taskTitle = title
    }
    
    func descriptionFieldUpdated(_ description: String?) {
        guard let description = description else { return }
        
        viewModel.taskDescription = description
    }
    
    func startDateUpdated(_ dateStr: String?) {
        guard let dateStr = dateStr else { return }
        
        let date = dateStr.getDateFromString() ?? Date()
        viewModel.taskStartDate = date
    }
    
    func endDateUpdated(_ dateStr: String?) {
        guard let dateStr = dateStr else { return }
        
        let date = dateStr.getDateFromString() ?? Date()
        viewModel.taskEndDate = date
    }
    
    func priorityUpdated(_ priority: Priority?) {
        guard let priority = priority else { return }
        
        viewModel.taskPriority = priority
    }
    
    func attachBtnClicked() {
        let pickerViewController = UIImagePickerController()
        pickerViewController.delegate = self
        pickerViewController.sourceType = .photoLibrary
        present(pickerViewController, animated: true, completion: nil)
    }
}

// MARK: Image picking delegates

extension TaskVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            formView.setAttachedImage(pickedImage)
            viewModel.taskAttachedImage = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Form Submission

extension TaskVC {
    @objc func submitForm(_ sender: UIButton) {
        if let button = sender as? SimpleButton {
            button.animate()
        }
        formView.releaseAllResponders()
        
        if let status = viewModel.validateForm() {
            showDefaultAlertPopUp(with: status, title: "Error", completionHandler: nil)
        } else {
            if(isNew){
                showActivityIndicator(withText: "Creating new task")
                viewModel.saveTask { [weak self] in
                    self?.hideActivityIndicator()
                    self?.showDefaultAlertPopUp(with: "New task created.", title: "Success", completionHandler: {
                        self?.navigationController?.popViewController(animated: true)
                    })
//                    self?.navigationController?.popViewController(animated: true)
                }
            } else {
                showActivityIndicator(withText: "Modifying the task")
                viewModel.modifyTask { [weak self] in
                    self?.hideActivityIndicator()
                    self?.showDefaultAlertPopUp(with: "Your task have updated.", title: "Success", completionHandler: {
                        self?.navigationController?.popViewController(animated: true)
                    })
//                    self?.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }
}
