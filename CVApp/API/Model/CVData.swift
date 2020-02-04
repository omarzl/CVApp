//
//  CVData.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import Foundation

struct CVData: Decodable {
    
    let text: String
    let image: String
    
    init(text: String = "", image: String = "") {
        self.text = text
        self.image = image
    }
}
