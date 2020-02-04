//
//  MainWireframe.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

final class MainWireframe {

    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }

    func showView(presenter: MainPresenter) {
        window?.rootViewController = MainController(presenter: presenter)
    }
}
