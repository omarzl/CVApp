//
//  MainController.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

final class MainController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            listAdapter.collectionView = collectionView
            listAdapter.dataSource = dataSource
            listAdapter.scrollViewDelegate = self
        }
    }
    
    private let dataSource = MainDataSource()
    private lazy var listAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    private let disposeBag = DisposeBag()
    private let presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: MainController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

private extension MainController {
    func bind() {
        let output = presenter.setup(input: ())
        
        output
            .bind(to: listAdapter.rx.items(at: dataSource))
            .disposed(by: disposeBag)
    }
}

extension MainController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listAdapter.visibleSectionControllers().forEach {
            guard let sectionController = $0 as? ScrollingSectionController else { return }
            let diffHeight = CGFloat(sectionController.item.index) * sectionController.height
            if sectionController.item.index == 1 {
                sectionController.didScroll(offset: scrollView.contentOffset.y - diffHeight)
            }
        }
    }
}


