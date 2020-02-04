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
        return .create { single -> Disposable in
            let url = "https://demo4947727.mockable.io/vc"
            Alamofire.request(url).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        single(.error(RxError.unknown))
                        return
                    }
                    let result = try? JSONDecoder().decode([CVData].self, from: data)
                    single(.success(result ?? []))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
