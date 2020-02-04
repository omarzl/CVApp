//
//  MainDataSource.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import IGListKit
import RxSwift

class MainDataSource: NSObject {

    var data: [ListDiffable] = []
}

extension MainDataSource: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return EmptySectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension MainDataSource: RxListAdapter {
    func listAdapter(_ adapter: ListAdapter, observeredEvent event: Event<[ListDiffable]>) {
        guard case .next(let elements) = event else { return }
        data = elements
        adapter.performUpdates(animated: false)
    }
}

