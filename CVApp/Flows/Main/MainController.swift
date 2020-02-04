//
//  MainController.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit

final class MainController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: MainController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
