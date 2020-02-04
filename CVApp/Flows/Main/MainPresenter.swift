//
//  MainPresenter.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

final class MainPresenter {

    private let wireframe: MainWireframe
    
    init(wireframe: MainWireframe) {
        self.wireframe = wireframe
    }
    
    func start() {
        wireframe.showView(presenter: self)
    }
}
