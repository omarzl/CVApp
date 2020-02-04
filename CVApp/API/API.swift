//
//  API.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import RxSwift
import Alamofire

class API {
    func getCVData() -> Single<[CVData]> {
        return Single<[CVData]>.error(RxError.timeout).delay(.milliseconds(500), scheduler: MainScheduler.instance)
//        return .create { single -> Disposable in
//            let url = ""
//            Alamofire.request(url).responseJSON { (response) in
//                switch response.result {
//                case .success:
//                    guard let data = response.data else {
//                        single(.error(RxError.unknown))
//                        return
//                    }
//                    let result = try? JSONDecoder().decode([CVData].self, from: data)
//                    single(.success(result ?? []))
//                case .failure(let error):
//                    single(.error(error))
//                }
//            }
//            return Disposables.create()
//        }
    }
}
