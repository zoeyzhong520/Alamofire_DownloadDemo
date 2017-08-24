//
//  NetworkTool.swift
//  NetworkTool
//
//  Created by JOE on 2017/6/30.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTool : NSObject {
    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, headers: HTTPHeaders?, finishedCallback : @escaping (_ result : Any) -> (), failedCallback : @escaping (_ error : NSError) -> ()) {
        
        print(URLString)
        
        //获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, headers: headers).validate().responseData { (response) in
            
            //获取结果
            switch response.result {
            case .success:
                guard let data = response.data else {
                    print(response.result.error!)
                    return
                }
                
                //将结果回调出去
                finishedCallback(data)
            case .failure(let nserror):
                failedCallback(nserror as NSError)
            }
        }
    }
    
    /// upload file
    class func uploadFile(URLString: String, parameters: [String : Any], headers: HTTPHeaders?, fileURL: URL, fileName: String, finishedCallback : @escaping (_ result : Any) -> (), failedCallback : @escaping (_ error : NSError) -> ()) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(fileURL, withName: fileName)
            
            for (key, value) in parameters {
                if let data = (value as? String)?.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: URLString, method: .post, headers: headers) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: { (response) in
                    guard let data = response.data else { return }
                    
                    /// 将结果回调出去
                    finishedCallback(data)
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    print(response)
                })
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
            case .failure(let encodingError):
                print(encodingError)
                failedCallback(encodingError as NSError)
            }
        }
        
       //Alamofire.upload(multipartFormData: <#T##(MultipartFormData) -> Void#>, usingThreshold: <#T##UInt64#>, to: <#T##URLConvertible#>, method: <#T##HTTPMethod#>, headers: <#T##HTTPHeaders?#>, encodingCompletion: <#T##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##(SessionManager.MultipartFormDataEncodingResult) -> Void#>)
    }
}










