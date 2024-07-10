//
//  Double+Extension.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import Foundation

extension Double {
    func asDegreeCelcius() -> String {
        let str = String(format: "%.0f", self)
        return str + "°C"
    }
}
