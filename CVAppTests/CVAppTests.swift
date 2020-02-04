//
//  CVAppTests.swift
//  CVAppTests
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import XCTest
import RxSwift
@testable import CVApp

class CVAppTests: XCTestCase {
    
    let presenter: MainPresenter = {
        let wireframe = MainWireframe(window: nil)
        let api = TestAPI()
        return MainPresenter(wireframe: wireframe, api: api)
    }()
    
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    func testData() {
        let output = presenter.setup(input: Observable<Void>.empty())
        output.diffables
            .subscribe(onNext: { [weak self] diffables in
                guard let items = diffables as? [MainItem] else {
                    XCTAssertTrue(false, "The mapping is wrong!")
                    return
                }
                self?.validate(data: items)
            })
            .disposed(by: disposeBag)
    }
    
    func validate(data: [MainItem]) {
        XCTAssertTrue(data.count == 2)
        data.forEach {
            XCTAssertTrue($0.backgroundColor != .clear, "Something is wrong with the color mapping")
        }
    }
}
