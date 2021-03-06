//
//  ScrollingSectionController.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

protocol ScrollingSectionController {
    
    var height: CGFloat { get }
    var item: MainItem { get }
    
    func didScroll(offset: CGFloat, viewSize: CGSize)
}

extension ScrollingSectionController {
    var height: CGFloat { return UIScreen.main.bounds.size.width / 2 }
}
