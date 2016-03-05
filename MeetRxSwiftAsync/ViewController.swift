//
//  ViewController.swift
//  MeetRxSwiftAsync
//
//  Created by 宋宋 on 16/3/5.
//  Copyright © 2016年 T. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        requestJSON(.GET, "https://rxswift.leanapp.cn/users")
            .flatMap { result -> Observable<(NSHTTPURLResponse, AnyObject)> in
                print("Result: \(result.1)")
                return requestJSON(.GET, "https://rxswift.leanapp.cn/users")
            }
            .subscribe(onNext: {
                print("Result: \($0.1)")
                }, onError: {
                print("Error: \($0)")
                })
            .addDisposableTo(disposeBag)
        
    }

}
