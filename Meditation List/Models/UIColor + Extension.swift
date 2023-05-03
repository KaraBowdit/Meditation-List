//
//  UIColor + Extension.swift
//  Meditation List
//
//  Created by Haley Jones on 5/3/23.
//

import UIKit

//Go-to extension for translating Hex Colors to UIColor
extension UIColor {
    convenience init(hexValue: String) {
    var sanitizedString = hexValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if sanitizedString.hasPrefix("#") {
        sanitizedString.removeFirst()
    }

    if sanitizedString.count != 6 {
        self.init(hexValue:"ff0000") // red as the error color
      return
    }

    var rgbValue: UInt64 = 0
    Scanner(string: sanitizedString).scanHexInt64(&rgbValue)

    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: 1.0)
    }
}
