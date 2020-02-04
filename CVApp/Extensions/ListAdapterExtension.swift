//
//  ListAdapterExtension.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import IGListKit
import RxSwift

protocol RxListAdapter {
    associatedtype Element
    func listAdapter(_ adapter: ListAdapter, observeredEvent event: Event<Element>)
}

extension Reactive where Base: ListAdapter {
    
    func items<T: RxListAdapter & ListAdapterDataSource, O: ObservableType>(at dataSource: T) -> (_ source:O) -> Disposable where T.Element == O.Element {
        return { source in
            let subscription = source
                .subscribe { [weak dataSource] in
                    dataSource?.listAdapter(self.base, observeredEvent: $0)
            }
            
            return Disposables.create {
                subscription.dispose()
            }
        }
    }
    
    func set<T: RxListAdapter & ListAdapterDataSource>(datasource item: T) -> Disposable {
        base.dataSource = item
        return Disposables.create()
    }
}

extension ListSectionController {
    func reuse<T: UICollectionViewCell>(at index: Int) -> T {
        guard let context = collectionContext else { return T() }
        let cell: T = context.dequeueReusableCell(with: T.self, for: self, at: index)
        return cell
    }
}

extension ListCollectionContext {
    func dequeueReusableCell<T>(with cellType: T.Type, for sectionController: ListSectionController, at index: Int) -> T where T: UICollectionViewCell {
        let nibName = String(describing: cellType)
        guard let cell = dequeueReusableCell(withNibName: nibName, bundle: nil, for: sectionController, at: index) as? T else { return T() }
        return cell
    }
}
