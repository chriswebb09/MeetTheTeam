//
//  APIClient.swift
//  Team
//
//  Created by Christopher Webb-Orenstein on 12/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
//
import UIKit
typealias JSONData = [String : Any]

class APIClient {
    
    var queue = OperationQueue()
    static let sharedInstance = APIClient()
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let urlRequest = URLRequest(url:url)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            completion(data, response, error)
        }).resume()
    }
    
    func downloadImage(url: URL, handler: @escaping (UIImage) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            let op1 = BlockOperation(block: {
                guard let data = data, error == nil else { return }
                OperationQueue.main.addOperation({
                    handler(UIImage(data: data)!)
                })
            })
            op1.completionBlock = {
                print("Op1 finished")
            }
            self.queue.addOperation(op1)
        }
    }
}



