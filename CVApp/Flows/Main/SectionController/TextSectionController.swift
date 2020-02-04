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
    private let imageTransformSubject = PublishRelay<CGAffineTransform>()
    
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
        cell.set(image: "https://i.picsum.photos/id/599/300/150.jpg")
        textTransformSubject
            .bind(to: cell.rx.textTransform)
            .disposed(by: cell.disposeBag)
        
        imageTransformSubject
            .bind(to: cell.rx.imageTransform)
            .disposed(by: cell.disposeBag)
        return cell
    }
    
    func didScroll(offset: CGFloat, viewSize: CGSize) {
        var textScale: CGFloat
        var imageScale: CGFloat
        guard offset > -viewSize.height else { return }
        let diff = offset + viewSize.height
        if diff < (height / 2) {
            textScale = 0.1
            imageScale = 1.5
        } else if diff < height {
            textScale = 0.1 + diff * 0.9 / height
            imageScale = 2.0 - diff * 1.0 / height
        } else if offset > 0, offset < (height / 2) {
            textScale = 0.1 + (height - offset) * 0.9 / (height / 2)
            imageScale = 1.0 + offset * 0.5 / (height / 2)
        } else if offset > (height / 2) {
            textScale = 0.1
            imageScale = 1.5
        } else {
            textScale = 1.0 + (diff - height) * 1.0 / height
            imageScale = 1.0
        }
        textScale = textScale < 2.0 ? textScale : 2.0
        imageScale = imageScale > 1.0 ? imageScale : 1.0
        textTransformSubject.accept(CGAffineTransform(scaleX: textScale, y: textScale))
        imageTransformSubject.accept(CGAffineTransform(scaleX: imageScale, y: imageScale))
    }
}


