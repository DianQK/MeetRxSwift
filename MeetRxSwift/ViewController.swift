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
        
        textField.addTarget(self, action: "updateResultLabel:", forControlEvents: .EditingChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        resultLabel.addObserver(self, forKeyPath: "text", options: .New, context: nil)
    }
    
    func updateResultLabel(textField: UITextField) {
        resultLabel.text = textField.text
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let label = object as? UILabel where keyPath == "text" {
            print(label.text)
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit {
        resultLabel.removeObserver(self, forKeyPath: "text")
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialValue.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwiftGGCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = initialValue[indexPath.row].name
        cell.detailTextLabel?.text = initialValue[indexPath.row].state
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Click")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}
