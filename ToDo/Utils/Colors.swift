//
//  Colors.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import Foundation
import UIKit

struct Colors {
    static let theme = DefaultTheme()
}

struct DefaultTheme {
    let primaryColor: UIColor = UIColor(named: "primaryColor")!
    let secondaryColor: UIColor = UIColor(named: "secondaryColor")!
    let textColor: UIColor = UIColor(named: "textColor")!
    let secondaryTextColor: UIColor = UIColor(named: "secondaryTextColor")!
    
    let highPriorityColor: UIColor = UIColor(named: "highPriorityColor")!
    let mediumPriorityColor: UIColor = UIColor(named: "mediumPriorityColor")!
    let normalPriorityColor: UIColor = UIColor(named: "normalPriorityColor")!
    let lowPriorityColor: UIColor = UIColor(named: "lowPriorityColor")!
    
    let highPriorityDarkColor: UIColor = UIColor(named: "highPriorityDarkColor")!
    let mediumPriorityDarkColor: UIColor = UIColor(named: "mediumPriorityDarkColor")!
    let normalPriorityDarkColor: UIColor = UIColor(named: "normalPriorityDarkColor")!
    let lowPriorityDarkColor: UIColor = UIColor(named: "lowPriorityDarkColor")!
    
    let secondaryBgColor: UIColor = UIColor(named: "secondaryBgColor")!
}
