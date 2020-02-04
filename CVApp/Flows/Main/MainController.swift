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
import SwiftMessages

final class MainController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            listAdapter.collectionView = collectionView
            listAdapter.dataSource = dataSource
            listAdapter.scrollViewDelegate = self
        }
    }
    private let pullToRefresh = UIRefreshControl()
    
    private let reloadData = PublishRelay<Void>()
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
        setupView()
        bind()
    }
}

private extension MainController {
    func setupView() {
        collectionView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(reload), for: .valueChanged)
    }
    
    @objc func reload() {
        reloadData.accept(())
    }
    
    func bind() {
        let output = presenter.setup(input: reloadData.asObservable())
        
        output.loading
            .subscribeNext(weak: self) { $0.setup(loading:) }
            .disposed(by: disposeBag)
        
        output.error
            .subscribeNext(weak: self) { $0.show(error:) }
            .disposed(by: disposeBag)
        
        output.diffables
            .do(afterNext: { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async { self.scrollViewDidScroll(self.collectionView) }
            })
            .bind(to: listAdapter.rx.items(at: dataSource))
            .disposed(by: disposeBag)
    }
    
    func setup(loading: Bool) {
        if loading {
            pullToRefresh.beginRefreshingManually()
        } else {
            pullToRefresh.endRefreshing()
        }
    }
    
    func show(error: Error) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureContent(title: "Error", body: error.localizedDescription)
        view.button?.isHidden = true
        var config = SwiftMessages.Config()
        config.duration = .automatic
        SwiftMessages.show(config: config, view: view)
    }
}

extension MainController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listAdapter.visibleSectionControllers().forEach {
            guard let sectionController = $0 as? ScrollingSectionController else { return }
            let diffHeight = CGFloat(sectionController.item.index) * sectionController.height
            sectionController.didScroll(offset: scrollView.contentOffset.y - diffHeight, viewSize: collectionView.frame.size)
        }
    }
}


