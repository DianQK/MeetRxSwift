//
//  ViewController.swift
//  MeetRxSwiftAsync
//
//  Created by 宋宋 on 16/3/5.
//  Copyright © 2016年 T. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "https://rxswift.leanapp.cn/users").responseJSON { response in
            switch response.result {
            case .Success(let value):
                print("Result: \(value)")
                
                Alamofire.request(.GET, "https://rxswift.leanapp.cn/users").responseJSON { response in
                    switch response.result {
                    case .Success(let value):
                        print("Result: \(value)")
                    case .Failure(let error):
                        print("Error: \(error)")
                    }
                    
                }
            case .Failure(let error):
                print("Error: \(error)")
            }
        }
        /**
        *  1. 可能还需要 JSON -> Model 的解析，可能我们在这里会做一下封装，但这其实和继承有些类似。都是依赖于之前的代码
        *  进行添加，嵌套，都是一种嵌套的感觉。
        *  2. 可能还有重复请求的需求，请求失败再请求一两次之类的。
        */
    }

}

