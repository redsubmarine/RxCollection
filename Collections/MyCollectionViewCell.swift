//
//  MyCollectionViewCell.swift
//  RMoney
//
//  Created by 양원석 on 06/11/2018.
//  Copyright © 2018 red. All rights reserved.
//

import UIKit
import RxSwift

class MyCollectionViewCell: UICollectionViewCell, Cell {
    class func bundle() -> CellStyleBundle<Void> {
        return CellStyleBundle(type: self)
    }
    
    static var nibName: String? = "MyCollectionViewCell"
    static var reuseIdentifier: String = "MyCollectionViewCell"
    
    var disposeBag: DisposeBag = DisposeBag()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var border: UIView!
    
    var presenter: UIViewController?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        border.backgroundColor = .lightGray
    }
    
    func apply(cellInfo: CellInfo) {
        guard case let .sample(num) = cellInfo.data else {
            return
        }
        label.text = "\(num)"
        contentView.backgroundColor = .yellow
    }
    
    static func cellSize(info: CellInfo) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 44.0)
    }
}
