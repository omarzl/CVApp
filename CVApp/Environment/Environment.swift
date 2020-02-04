//
//  Environment.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import Foundation

enum Environment {
    case develop
    case release
    
    static let currentEnv: Environment = {
        #if DEVELOP
        return  .develop
        #else
        return .release
        #endif
    }()
}
