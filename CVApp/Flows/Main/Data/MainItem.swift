
//
//  MainItem.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import Foundation
import IGListKit

class MainItem: NSObject, ListDiffable {
    
    let index: Int
    
    init(index: Int, data: CVData) {
        self.index = index
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return index as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MainItem else { return false }
        return isEqual(object)
    }
}
