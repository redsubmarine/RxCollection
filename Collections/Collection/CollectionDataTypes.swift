//
//  CollectionDataTypes.swift
//  RMoney
//
//  Created by 양원석 on 2018. 7. 19..
//  Copyright © 2018년 red. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

struct SectionData {
    var items: [Item]
    var id: String
    
    init(id: String, items: [Item]) {
        self.id = id
        self.items = items
    }
}

extension SectionData: AnimatableSectionModelType {
    var identity: String {
        return id
    }
    
    typealias Item = CellInfo
    
    init(original: SectionData, items: [Item]) {
        self = original
        self.items = items
    }
}

enum CellData {
    case none
    case issue(issue: IssueDisplayable)
}

protocol CellStyle {
    var cellType: Cell.Type { get }
}

protocol Cell: class {
    static var nibName: String? { get }
    static var reuseIdentifier: String { get }
    
    var disposeBag: DisposeBag { get set }
    var presenter: UIViewController? { get set }
    
    func apply(cellInfo: CellInfo)
    static func cellHeight(info: CellInfo) -> CGFloat
    static func cellSize(info: CellInfo) -> CGSize
}

extension Cell {
    static func cellHeight(info: CellInfo) -> CGFloat {
        return 0.0
    }
    
    static func cellSize(info: CellInfo) -> CGSize {
        return .zero
    }
}

struct CellInfo: IdentifiableType, Equatable {
    let id: String
    let data: CellData
    let style: CellStyle
    
    var identity: String {
        return id
    }
    
    public static func == (lhs: CellInfo, rhs: CellInfo) -> Bool {
        return lhs.identity == rhs.identity
    }
}


protocol HasCollectionData {
    var dataSource: Observable<[SectionData]> { get }
}


class CellStyleBundle<T>: CellStyle {
    let type: Cell.Type
    let parameters: T?
    
    init(type: Cell.Type, parameters: T? = nil) {
        self.type = type
        self.parameters = parameters
    }
    
    var cellType: Cell.Type {
        return self.type
    }
    
    var hash: Int {
        get {
            return self.type.reuseIdentifier.hash
        }
    }
}

extension UITableView {
    func register(cellType: Cell.Type) {
        if let nibName = cellType.nibName, !nibName.isEmpty {
            register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellType.reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
}

extension UICollectionView {
    func register(cellType: Cell.Type) {
        if let nibName = cellType.nibName, !nibName.isEmpty {
            register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: cellType.reuseIdentifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        }
        
    }
}

