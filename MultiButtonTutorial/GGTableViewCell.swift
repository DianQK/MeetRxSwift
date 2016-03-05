//
//  GGTableViewCell.swift
//  MeetRxSwift
//
//  Created by 宋宋 on 16/3/5.
//  Copyright © 2016年 T. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GGTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    let dataSource = Variable([String]())
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource.asObservable()
            .bindTo(collectionView.rx_itemsWithCellIdentifier("GGCollectionViewCell", cellType: GGCollectionViewCell.self)) { (_, element, cell) in
            
                cell.imageView.image = UIImage(named: element)
                
            }
            .addDisposableTo(disposeBag)
    }
    
    func bindWithData() -> CGFloat {
        collectionView.reloadData()
//        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize().height
//        self.updateConstraintsIfNeeded()
//        self.setNeedsUpdateConstraints()
        
        return 5 + 20 + collectionViewHeightConstraint.constant
    }

}
