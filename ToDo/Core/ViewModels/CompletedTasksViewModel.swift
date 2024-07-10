//
//  CompletedTasksViewModel.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import Foundation

class CompletedTasksViewModel {
    
    private let coreDataManager = CoreDataManager.instance
    
    var onTaskListUpdate: (() -> Void)?
    var taskList: [Task] = [] {
        didSet {
            DispatchQueue.main.async{ [weak self] in
                self?.onTaskListUpdate?()
            }
        }
    }
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchTaskList()
        }
    }
    
    func fetchTaskList() {
        taskList = coreDataManager.fetchCompletedTasks()
    }
    
}
