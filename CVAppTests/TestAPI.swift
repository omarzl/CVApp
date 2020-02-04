//
//  TestAPI.swift
//  CVAppTests
//
//  Created by Omar Zúñiga Lagunas on 2/4/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import XCTest
import RxSwift
@testable import CVApp

class TestAPI: APIProvider {
    func getCVData() -> Single<[CVData]> {
        guard let data = readArrayJson(fileName: "data") else {
            XCTAssertTrue(false, "The data cant be read!")
            return .just([])
        }
        return .create { single -> Disposable in
            let result = try? JSONDecoder().decode([CVData].self, from: data)
            single(.success(result ?? []))
            return Disposables.create()
        }
    }
    
    func readArrayJson(fileName: String) -> Data? {
        do {
            if let file = Bundle(for: TestAPI.self).url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                return data
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
