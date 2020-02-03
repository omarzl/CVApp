//
//  RootFlow.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

class RootFlow {

    func start() -> UIWindow? {
        let window = UIWindow()
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        return window
    }
}
