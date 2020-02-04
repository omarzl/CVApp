
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
    let text: String
    let image: String
    let textColor: UIColor
    let backgroundColor: UIColor
    
    init(index: Int, data: CVData) {
        self.index = index
        text = data.text
        image = data.image
        textColor = UIColor(hex: data.textColor)
        backgroundColor = UIColor(hex: data.backgroundColor)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return index as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MainItem else { return false }
        return isEqual(object)
    }
}
