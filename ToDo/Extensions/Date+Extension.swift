//
//  Date+Extension.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation

extension Date {
    
    func getStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getStringFromDate(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
