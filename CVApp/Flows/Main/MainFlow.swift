//
//  MainFlow.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

final class MainFlow {
    
    private let presenter: MainPresenter

    init(window: UIWindow?) {
        let wireframe = MainWireframe(window: window)
        presenter = MainPresenter(wireframe: wireframe)
    }
    
    func start() {
        presenter.start()
    }
}
