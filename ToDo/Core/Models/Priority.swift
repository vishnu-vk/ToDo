//
//  Priority.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import Foundation

enum Priority: String, CaseIterable, Decodable {
    case high, medium, normal, low
    var priorityValue: Int {
        switch(self){
            case .high: return 4
            case .medium: return 3
            case .normal: return 2
            case .low: return 1
        }
    }
}

extension Priority {
    func indexOf() -> Int? {
        return Priority.allCases.firstIndex(of: self)
    }
}
