//
//  TextSectionController.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import IGListKit
import RxSwift
import RxCocoa

class TextSectionController: ListSectionController, ScrollingSectionController {
    
    private(set) var item = MainItem(index: 0)
    private let textTransformSubject = PublishRelay<CGAffineTransform>()
    
    override func didUpdate(to object: Any) {
        guard let object = object as? MainItem else { return }
        item = object
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize else { return .zero }
        return CGSize(width: containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: TextCell = reuse(at: index)
        textTransformSubject
            .bind(to: cell.rx.textTransform)
            .disposed(by: cell.disposeBag)
        return cell
    }
    
    func didScroll(offset: CGFloat, viewSize: CGSize) {
        var scale: CGFloat
        guard offset > -viewSize.height else { return }
        let diff = offset + viewSize.height
        if diff < (height / 2) {
            scale = 0.1
        } else if diff < height {
            scale = 0.1 + diff * 0.9 / height
        } else if offset > 0, offset < (height / 2) {
            scale = 0.1 + (height - offset) * 0.9 / (height / 2)
        } else if offset > (height / 2) {
            scale = 0.1
        } else {
            scale = 1.0 + (diff - height) * 1.0 / height
        }
        scale = scale < 2.0 ? scale : 2.0
        textTransformSubject.accept(CGAffineTransform(scaleX: scale, y: scale))
    }
}


