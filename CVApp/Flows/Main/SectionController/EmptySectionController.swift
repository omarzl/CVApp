//
//  EmptySectionController.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import IGListKit

protocol ScrollingSectionController {
    
    var height: CGFloat { get }
    var item: MainItem { get }
    
    func didScroll(offset: CGFloat)
}

extension ScrollingSectionController {
    var height: CGFloat { return 200 }
}

class EmptySectionController: ListSectionController, ScrollingSectionController {
    
    private(set) var item = MainItem(index: 0)
    
    override func didUpdate(to object: Any) {
        guard let object = object as? MainItem else { return }
        item = object
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize else { return .zero }
        return CGSize(width: containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: EmptyCell = reuse(at: index)
        return cell
    }
    
    func didScroll(offset: CGFloat) {
        if item.index == 1 {
            print(offset)
        }
    }
}


