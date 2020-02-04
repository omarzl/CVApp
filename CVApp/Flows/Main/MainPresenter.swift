//
//  MainPresenter.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import RxSwift
import IGListKit

typealias MainOutput = (
    Observable<[ListDiffable]>
)

typealias MainInput = (
)

final class MainPresenter {

    private let wireframe: MainWireframe
    
    init(wireframe: MainWireframe) {
        self.wireframe = wireframe
    }
    
    func start() {
        wireframe.showView(presenter: self)
    }
    
    func setup(input: MainInput) -> MainOutput {
        return Observable<[ListDiffable]>.just([MainItem(index: 0), MainItem(index: 1), MainItem(index: 2), MainItem(index: 3), MainItem(index: 4), MainItem(index: 5)])
    }
}
