//
//  ClassifyViewController.swift
//  FM
//
//  Created by elliot xin on 2/18/18.
//  Copyright © 2018 elliot xin. All rights reserved.
//

import UIKit

class ClassifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //发送一个名字为currentPageChanged，附带object的值代表当前页面的索引
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "currentPageChanged") , object: 1)
        
    }

}
