//
//  Fonts.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import Foundation
import UIKit

let black = "Poppins-Black"
let blackItalic = "Poppins-BlackItalic"
let bold = "Poppins-Bold"
let boldItalic = "Poppins-BoldItalic"
let extraBold = "Poppins-ExtraBold"
let extraBoldItalic = "Poppins-ExtraBoldItalic"
let extraLight = "Poppins-ExtraLight"
let extraLightItalic = "Poppins-ExtraLightItalic"
let italic = "Poppins-Italic"
let light = "Poppins-Light"
let lightItalic = "Poppins-LightItalic"
let medium = "Poppins-Medium"
let mediumItalic = "Poppins-MediumItalic"
let regular = "Poppins-Regular"
let semiBold = "Poppins-SemiBold"
let semiBoldItalic = "Poppins-SemiBoldItalic"
let thin = "Poppins-Thin"
let thinItalic = "Poppins-ThinItalic"

struct Fonts {
    static let primaryHeading = UIFont(name: bold, size: 32)
    static let secondaryHeading = UIFont(name: semiBold, size: 24)
    static let tertiaryHeading = UIFont(name: medium, size: 20)
    static let body = UIFont(name: regular, size: 16)
    static let boldBody = UIFont(name: semiBold, size: 16)
    static let caption = UIFont(name: light, size: 13)
    static let boldCaption = UIFont(name: semiBold, size: 13)
    static let regularCaption = UIFont(name: regular, size: 13)
    static let footnote = UIFont(name: thin, size: 11)
    static let regularFootnote = UIFont(name: regular, size: 11)
    static let tabBarNormal = UIFont(name: regular, size: 11)
    static let tabBarSelected = UIFont(name: bold, size: 11)
    static let navBarTitle = UIFont(name: bold, size: 34)
    static let navBarTitleSmall = UIFont(name: bold, size: 17)
    static let buttonBold = UIFont(name: semiBold, size: 14)
    static let buttonRegular = UIFont(name: regular, size: 14)
}

