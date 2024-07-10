//
//  TaskEntity+CoreDataClass.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//
//

import Foundation
import CoreData

@objc(TaskEntity)
public class TaskEntity: NSManagedObject {
    
    func update(with task: Task) {
        self.id = task.id
        self.title = task.title
        self.taskDescription = task.taskDescription
        self.startDate = task.startDate
        self.endDate = task.endDate
        self.progress = task.taskStatus
        self.attachmentUrl = task.attachmentUrl
        self.priority = task.priority.rawValue
    }
    
    func toTask() -> Task {
        return Task(
                    id: self.id,
                    title: self.title,
                    taskDescription: self.taskDescription,
                    startDate: self.startDate,
                    endDate: self.endDate,
                    priority: Priority(rawValue: self.priority) ?? .normal,
                    taskStatus: self.progress,
                    attachmentUrl: self.attachmentUrl ?? nil
                    )
    }
    
}
