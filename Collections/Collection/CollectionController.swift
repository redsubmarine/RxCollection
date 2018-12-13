//
//  CollectionController.swift
//  RMoney
//
//  Created by 양원석 on 2018. 7. 19..
//  Copyright © 2018년 red. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

class CollectionController {
    
    enum CollectionType {
        case tableView, collectionView
    }
    
    static func newInstance(type: CollectionType) -> CollectionController {
        return CollectionController(type: type)
    }
    
    private var type: CollectionType!
    
    var disposeBag =  DisposeBag()
    
    private init(type: CollectionType) {
        self.type = type
    }
    
    private var tableDatasource: RxTableViewSectionedReloadDataSource<SectionData>!
    private var tableDelegate: TableViewDelegate!
    
    private var collectionDatasource: RxDataSources.CollectionViewSectionedDataSource<SectionData>!
    private var collectionViewDelegateFlowLayout: CollectionViewDelegateFlowLayout!
    
    func bind(to tableView: UITableView, source: Observable<[SectionData]>, viewController: UIViewController? = nil) {
        
        let configureCell: TableViewSectionedDataSource<SectionData>.ConfigureCell = { datasource, tableView, indexPath, item in
            
            let cellType = item.style.cellType
            let identifier = cellType.reuseIdentifier
            
            tableView.register(cellType: cellType)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            
            if let cell = cell as? Cell {
                cell.presenter = viewController
                cell.apply(cellInfo: item)
            }
            
            return cell
        }
        
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionData>(configureCell: configureCell)
        tableDatasource = dataSource
        tableDelegate = TableViewDelegate(source: dataSource)
        tableView.delegate = tableDelegate
        
        source
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    
    
    func bind(to collectionView: UICollectionView, source: Observable<[SectionData]>, viewController: UIViewController? = nil) {
        collectionView.alwaysBounceVertical = true
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionData>(configureCell: { datasource, collectionView, indexPath, item in
            let cellType = item.style.cellType
            let identifier = cellType.reuseIdentifier
            
            collectionView.register(cellType: cellType)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            
            if let cell = cell as? Cell {
                cell.presenter = viewController
                cell.apply(cellInfo: item)
            }
            
            return cell
        }, configureSupplementaryView: { dataSource ,collectionView, kind, indexPath in
            let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: indexPath)
            return section
        })
        
        collectionDatasource = dataSource
        collectionViewDelegateFlowLayout = CollectionViewDelegateFlowLayout(source: dataSource)
        collectionView.delegate = collectionViewDelegateFlowLayout
        
        source
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}


class TableViewDelegate: NSObject, UITableViewDelegate {
    let source: TableViewSectionedDataSource<SectionData>
    
    init(source: TableViewSectionedDataSource<SectionData>) {
        self.source = source
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellInfo = try! source.model(at: indexPath) as! CellInfo
        return cellInfo.style.cellType.cellHeight(info: cellInfo)
    }
    
}

class CollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    let source: RxDataSources.CollectionViewSectionedDataSource<SectionData>
    
    init(source: RxDataSources.CollectionViewSectionedDataSource<SectionData>) {
        self.source = source
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInfo = try! source.model(at: indexPath) as! CellInfo
        return cellInfo.style.cellType.cellSize(info: cellInfo)
    }
}

