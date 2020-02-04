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
import Nuke

class TextCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        imageView.image = nil
    }
    
    func set(text: String) {
        textLabel.text = text
    }
    
    func set(image: String) {
        guard let url = URL(string: image) else { return }
        Nuke.loadImage(with: url, options: ImageLoadingOptions(), into: imageView, progress: nil) { [imageView] result in
            switch result {
            case .success(let response):
                if response.urlResponse?.url != url { imageView?.image = nil }
            case .failure: break
            }
        }
    }
    
    func set(textTransform transform: CGAffineTransform) {
        textLabel.transform = transform
    }
    
    func set(imageTransform transform: CGAffineTransform) {
        imageView.transform = transform
    }
}

extension Reactive where Base: TextCell {
    var textTransform: Binder<CGAffineTransform> {
        return Binder(self.base) { cell, transform in
            cell.set(textTransform: transform)
        }
    }
    
    var imageTransform: Binder<CGAffineTransform> {
        return Binder(self.base) { cell, transform in
            cell.set(imageTransform: transform)
        }
    }
}
