//
//  Common.swift
//  FM
//
//  Created by elliot xin on 2/18/18.
//  Copyright © 2018 elliot xin. All rights reserved.
//

import UIKit
import SnapKit


// MARK:- 自定义打印方法
func FMLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}
