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

/// Documents目录路径
let zzj_DocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

let URLString = "http://54.223.77.112/epubs/2.epub"
/// 服务器上有4本 epub 格式的书，名字 分别是 1 2 3 4"

class ViewController: UIViewController {
    
    /// 下载请求对象
    var downloadRequest:DownloadRequest?
    
    /// 下载路径
    var destination:DownloadRequest.DownloadFileDestination!
    
    /// 用于停止下载时，保存已下载的部分
    var cancelledData: Data?
    
    /// 进度条
    var progressView:UIProgressView?
    
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
    
    fileprivate func getAllFile() -> [String]? {
        let downloadFile = FileManageHelper.getAllFilePath(zzj_DocumentPath)
        print("downloadFile: \(downloadFile!)")
        return downloadFile
    }
    
    fileprivate func createView() {
        self.title = "Alamofire_DownloadDemo"
        self.view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: 100)
        button.setTitle("点击下载epub", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        progressView = UIProgressView(frame: CGRect(x: 50, y: button.frame.maxY, width: ScreenWidth - 100, height: 20))
        self.view.addSubview(progressView!)
    }
    
    @objc fileprivate func buttonPressed() {
        
        guard let downloadFile = getAllFile() else { return }
        print(downloadFile[0])
        
        let substring = String().substring(targetString: "epubs/", parentString: URLString)
        print("substring: \(substring)")
        
        var isExist: Bool = false
        for file in downloadFile {
            if file == substring {
                //有已下载的epub
                isExist = true
                break
            }
        }
        
        if isExist == false {
            setupDownloadRequest()
        }else{
            showHudWithDuration(in: self.view, hint: "已下载过\(substring)")
        }
    }
    
    fileprivate func setupDownloadRequest() {
        destination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        /// 开始下载
        downloadRequest = Alamofire.download(URLString, to: destination)
        downloadRequest?.downloadProgress(queue: DispatchQueue.main, closure: downloadProgress(progress:))
        downloadRequest?.responseData(completionHandler: downloadResponse)
    }
    
    @objc fileprivate func downloadProgress(progress: Progress) {
        /// 进度条更新
        progressView?.progress = Float(progress.fractionCompleted)
        print("当前进度：\(progress.fractionCompleted*100)%")
    }
    
    func downloadResponse(response: DownloadResponse<Data>) {
        switch response.result {
        case .success(let data):
            print("文件下载完毕: \(response)")
        case .failure:
            cancelledData = response.resumeData //意外终止的话，把已下载的数据储存起来
        }
    }
}
















