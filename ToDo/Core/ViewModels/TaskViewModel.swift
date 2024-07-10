//
//  TaskViewModel.swift
//  ToDo
//
//  Created by Vishnu on 07/07/24.
//

import Foundation
import UIKit

class TaskViewModel {
    
    var task: Task
    var taskTitle: String
    var taskDescription: String
    var taskStartDate: Date?
    var taskEndDate: Date?
    var taskPriority: Priority?
    var taskStatus: Bool = false
    var taskAttachedImage: UIImage?
    
    private var fileManager = LocalFileManager.instance
    private var coreDataManager = CoreDataManager.instance
    
    init(task: Task?) {
        if let task = task {
            self.task = task
            taskTitle = task.title
            taskDescription = task.taskDescription
            taskStartDate = task.startDate
            taskEndDate = task.endDate
            taskPriority = task.priority
            taskStatus = task.taskStatus
            
            if let image = fileManager.getImage(imageName: task.id, folderName: LocalFileManager.folderName) {
                taskAttachedImage = image
            }
        } else {
            self.task = Task()
            taskTitle = ""
            taskDescription = ""
        }
    }
    
    private func updateTask() {
        task.title = taskTitle
        task.taskDescription = taskDescription
        task.startDate = taskStartDate!
        task.endDate = taskEndDate!
        task.priority = taskPriority!
        task.taskStatus = taskStatus
        if let image = taskAttachedImage {
            fileManager.saveImage(image: image, imageName: task.id, folderName: LocalFileManager.folderName)
            task.attachmentUrl = task.id
        } else {
            task.attachmentUrl = nil
        }
    }
    
    func saveTask(completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.updateTask()
            self.coreDataManager.createTask(task: self.task)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    func modifyTask(completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.updateTask()
            self.coreDataManager.updateTask(task: self.task)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }

    func validateForm() -> String? {
        
        if(taskTitle.isEmpty) {
            return "Task title is empty"
        } else if(taskDescription.isEmpty) {
            return "Task description is empty"
        } else if(taskStartDate == nil) {
            return "Task start date is required"
        } else if(taskEndDate == nil) {
            return "Task end date is required"
        } else if(taskPriority == nil) {
            return "Task priority is required"
        }
        
        return nil
    }
    
}
