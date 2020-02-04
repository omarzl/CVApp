//
//  TextCell.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextCell: UICollectionViewCell {

    @IBOutlet private weak var textLabel: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func set(textTransform transform: CGAffineTransform) {
        textLabel.transform = transform
    }
}

extension Reactive where Base: TextCell {
    var textTransform: Binder<CGAffineTransform> {
        return Binder(self.base) { cell, transform in
            cell.set(textTransform: transform)
        }
    }
}
