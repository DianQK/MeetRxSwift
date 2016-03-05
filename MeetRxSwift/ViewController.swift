//
//  ViewController.swift
//  MeetRxSwift
//
//  Created by 宋宋 on 16/3/3.
//  Copyright © 2016年 T. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias CellModel = (name: String, state: String)

/// delegate Selector KVO
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let initialValue = [
        CellModel(name: "小锅", state: "Single"),
        CellModel(name: "小锅", state: "Single"),
        CellModel(name: "小锅", state: "Single"),
        CellModel(name: "小锅", state: "Single"),
        CellModel(name: "小锅", state: "Single"),
        CellModel(name: "小锅", state: "Single")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 绑定结果
        textField.rx_text
            .bindTo(resultLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        let dataSource = Variable([CellModel]())
        
        /// 数据绑定到 Cell
        dataSource.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("SwiftGGCell")) { (_, element, cell) in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = element.state
            }
            .addDisposableTo(disposeBag)
        
        /// Cell 点击处理
        tableView.rx_modelDeselected(CellModel)
            .subscribeNext {
                print($0)
            }
            .addDisposableTo(disposeBag)
        
        /// 观察 tableView contentOffset 的变化
        tableView.rx_contentOffset
            .subscribeNext {
                print($0)
            }
            .addDisposableTo(disposeBag)
        
        /// 添加数据
        dataSource.value.appendContentsOf(initialValue)
        
        /// KVO
        resultLabel.rx_observe(String.self, "text")
            .subscribeNext {
                print($0)
            }
            .addDisposableTo(disposeBag)
    }

}
