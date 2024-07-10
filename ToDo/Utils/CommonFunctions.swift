//
//  CommonFunctions.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import Foundation
import UIKit
class CommonFunctions {
    
    static func covertWeatherCodeToImage(from code:Int) -> UIImage {
        switch(code){
            case 0: return UIImage(systemName: "sun.min")!
            case 1,2,3: return UIImage(systemName: "cloud.sun")!
            case 45,48: return UIImage(systemName: "cloud.fog")!
            case 56,57,61,63,65: return UIImage(systemName: "cloud.drizzle")!
            case 66,67: return UIImage(systemName: "cloud.heavyrain")!
            case 71,73, 75, 77: return UIImage(systemName: "snowflake")!
            default: return UIImage(systemName: "cloud.bolt.rain")!
        }
    }
}
