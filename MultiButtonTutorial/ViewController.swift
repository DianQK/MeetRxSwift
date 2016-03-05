//
//  ViewController.swift
//  MultiButtonTutorial
//
//  Created by 宋宋 on 16/3/5.
//  Copyright © 2016年 T. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias Model = (name: String, items: [String])

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let dataSource = Variable([Model]())
    
    var heightDictionary = [Int: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("GGTableViewCell", cellType: GGTableViewCell.self)) { [unowned self] (row, element, cell) in
                cell.dataSource.value = element.items
                let height = cell.bindWithData()
                cell.resultLabel.text = "SwiftGG Height: \(height)"
                self.heightDictionary[row] = height
                cell.needsUpdateConstraints()
                cell.setNeedsUpdateConstraints()
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_modelSelected(Model)
            .subscribeNext {
                print($0)
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_setDelegate(self)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource.value = randomData()
    }

}

extension ViewController: UIScrollViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if let height = heightDictionary[indexPath.row] {
//            return height
//        }
        return 100 + 20 + 15
    }
}

extension ViewController {
    func randomData() -> [Model] {
        var model = [Model]()
        for _ in 1...randomInRange(10...15) {
            let count = randomInRange(1...10)
            model.append(Model(name: "SwiftGG\(count)"
                , items: [String](count: count, repeatedValue:"useless")))
        }
        return model
    }
    
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }
}