//
//  String+Util.swift
//  ReadBook
//
//  Created by JOE on 2017/8/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

extension String {
    
    /**
     * 传入 秒  得到  xx分钟xx秒
     */
    func getMMSSFromSS(totalTime: Int?) -> String {
        
        var format_time = ""
        
        if let seconds = totalTime {
            //format of minute
            let str_minute = seconds / 60
            //format of second
            let str_second = seconds % 60
            //format of time
            format_time = String(format: "%02d:%02d", str_minute, str_second)
            
            print("\(format_time)")
        }
        
        return format_time
    }
    
    /**
     * 截取指定字符串
     */
    func substring(targetString: String?, parentString: String?) -> String {
        
        var resultString = ""
        
        if let tempStr = targetString, let tempParentStr = parentString {
            
            if let range = tempParentStr.range(of: tempStr) {
                resultString = tempParentStr.substring(with: range.upperBound..<tempParentStr.endIndex)
            }
        }
        return resultString
    }
}












