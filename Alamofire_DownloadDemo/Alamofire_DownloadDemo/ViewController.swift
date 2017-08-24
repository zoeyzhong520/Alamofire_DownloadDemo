//
//  ViewController.swift
//  Alamofire_DownloadDemo
//
//  Created by JOE on 2017/8/24.
//  Copyright © 2017年 JOE. All rights reserved.
//

import UIKit
import Alamofire

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let URLString = "http://54.223.77.112/epubs/1.epub"
/// 服务器上有4本 epub 格式的书，名字 分别是 1 2 3 4"

class ViewController: UIViewController {
    
    /// 下载请求对象
    var downloadRequest:DownloadRequest?
    
    /// 下载路径
    var destination:DownloadRequest.DownloadFileDestination?
    
    /// 进度条
    var progress:UIProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension ViewController {
    
    fileprivate func createView() {
        self.title = "Alamofire_DownloadDemo"
        self.view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: 100)
        button.setTitle("开始阅读", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        progress = UIProgressView(frame: CGRect(x: 50, y: button.frame.maxY, width: ScreenWidth - 100, height: 20))
        self.view.addSubview(progress!)
    }
    
    @objc fileprivate func buttonPressed() {
        
        destination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            
            return (fileURL, [.createIntermediateDirectories])
        }
    }
}
















