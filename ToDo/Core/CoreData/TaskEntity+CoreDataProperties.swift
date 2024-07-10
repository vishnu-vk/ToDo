//
//  TaskEntity+CoreDataProperties.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var attachmentUrl: String?
    @NSManaged public var endDate: Date
    @NSManaged public var id: String
    @NSManaged public var priority: String
    @NSManaged public var progress: Bool
    @NSManaged public var startDate: Date
    @NSManaged public var taskDescription: String
    @NSManaged public var title: String

}

extension TaskEntity : Identifiable {

}
