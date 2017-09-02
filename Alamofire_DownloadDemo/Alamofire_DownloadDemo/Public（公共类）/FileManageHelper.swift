//
//  FileManageHelper.swift
//  ReadBook
//
//  Created by JOE on 2017/8/16.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

//MARK: - 
//MARK: 文件管理工具类
//MARK: -

import UIKit

class FileManageHelper: NSObject {

    /// 单例
    static let sharedInstance = FileManageHelper()
    private override init() {}
    
    //MARK: 根据路径获取文件
    
    /// 根据路径获取文件
    class func getAllFilePath(_ dirPath:String) -> [String]? {
        
        var filePaths = [String]()
        
        do {
            let array = try FileManager.default.contentsOfDirectory(atPath: dirPath)
            
            for fileName in array {
                var isDir:ObjCBool = true
                
                let fullPath = "\(dirPath)/\(fileName)"
                let fileNamePath = "\(fileName)"
                
                if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if !isDir.boolValue {
                        filePaths.append(fileNamePath)
                    }
                }
            }
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        
        return filePaths
    }
}






