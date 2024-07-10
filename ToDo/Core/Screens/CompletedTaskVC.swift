//
//  CompletedTaskVC.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit

class CompletedTaskVC: BaseViewController {

    private var tableView: UITableView!
    private let emptyView = EmptyView()
    
    private let viewModel = CompletedTasksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = Colors.theme.primaryColor
        
        addViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTaskList()
    }
    
    // MARK: Adding Sub Views
    
    private func addViews() {
        navConfiguration()
        addTasksListView()
        addEmptyView()
    }
    
    private func navConfiguration() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func addTasksListView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        
        viewModel.onTaskListUpdate = { [weak self] in
            self?.tableView.reloadData()
            if self?.viewModel.taskList.count == 0 {
                self?.emptyView.setAsHidden(isHidden: false)
            } else {
                self?.emptyView.setAsHidden(isHidden: true)
            }
        }
        
        view.addSubview(tableView)
    }
    
    private func addEmptyView() {
        view.addSubview(emptyView)
        
        emptyView.setTitle(text: "No tasks to display. Only completed task will be displayed here.")
        emptyView.setAsHidden(isHidden: true)
    }
    
    // MARK: Layout Contraints configuration
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyView.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }

}

// MARK: UITableView Delegates

extension CompletedTaskVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! TableViewCell
        let task = viewModel.taskList[indexPath.row]
        
        cell.title.text = task.title
        cell.note.text = task.taskDescription
        cell.date.text = "\(task.startDate.getStringFromDate(with: "dd MMM YY")) - \(task.endDate.getStringFromDate(with: "dd MMM YY"))"
        cell.setPriority(priority: task.priority)
        cell.setProgress(task.taskStatus)
        cell.setBoxNumber(number: indexPath.row + 1)
        
        return cell
    }
}
