//
//  Task.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation

struct Task: Identifiable, Decodable {
    var id: String = UUID().uuidString
    var title: String = ""
    var taskDescription: String = ""
    var startDate: Date = Date()
    var endDate: Date = Date()
    var priority: Priority = .normal
    var taskStatus: Bool = false
    var attachmentUrl: String?
}
