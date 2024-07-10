//
//  String+Extension.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation

extension String {
    
    func getDateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
