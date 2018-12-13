//
//  CollectionViewController.swift
//  RMoney
//
//  Created by 양원석 on 06/11/2018.
//  Copyright © 2018 red. All rights reserved.
//

import UIKit
import RxSwift

class CollectionViewController: UIViewController {

    @IBOutlet private (set) var collectionView: UICollectionView!
    let controller = CollectionController.newInstance(type: .collectionView)
    var viewModel: CollectionViewViewModel = CollectionViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        controller.bind(to: collectionView, source: viewModel.dataSource)
        
        collectionView.backgroundColor = .red
        
    }
 
}

struct CollectionViewViewModel: HasCollectionData {
    var dataSource: Observable<[SectionData]>
    
    init() {
        let items = [1,2,3,4,5]
            .map({ CellInfo(id: "\($0)", data: CellData.sample(num: $0), style: MyCollectionViewCell.bundle())})
        dataSource = Observable.just([
            SectionData(id: "1", items: items)
            ]).startWith([])
    }
}
