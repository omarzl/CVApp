//
//  MainPresenter.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import RxSwift
import IGListKit
import RxSwiftExt

typealias MainOutput = (
    loading: Observable<Bool>,
    diffables: Observable<[ListDiffable]>,
    error: Observable<Error>
)

typealias MainInput = (
    Observable<Void>
)

final class MainPresenter {

    private let wireframe: MainWireframe
    private let api: API
    
    init(wireframe: MainWireframe, api: API) {
        self.wireframe = wireframe
        self.api = api
    }
    
    func start() {
        wireframe.showView(presenter: self)
    }
    
    func setup(input: MainInput) -> MainOutput {
        
        let startFlow = input.share().startWith(())
        
        let data = startFlow.flatMap { [api] in
                api.getCVData()
                    .asObservable()
                    .map { $0.enumerated().map { MainItem(index: $0, data: $1) } }
                    .materialize()
            }
        .share(replay: 1, scope: .whileConnected)
        
        let loading = Observable.merge(
                startFlow.map { _ in true },
                data.elements().map { _ in false },
                data.errors().map { _ in false }
            )
            .share()
        
        return (
            loading: loading,
            diffables: data.elements().map { $0 as [ListDiffable] },
            error: data.errors()
        )
    }
}


