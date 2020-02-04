//
//  StringExtension.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/4/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var trimmed = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if trimmed.hasPrefix("#") { trimmed.remove(at: trimmed.startIndex) }
        if trimmed.count != 6 { self.init(white: 1.0, alpha: 1.0) }
        
        var rgbValue:UInt64 = 0
        Scanner(string: trimmed).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
