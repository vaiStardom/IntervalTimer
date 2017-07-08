//
//  IntervalTimerNetworkJSON.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-03.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class IntervalTimerNetworkJSON {
    
    //MARK: - Properties
    fileprivate var url: URL
    
    //MARK: - Public get/set properties
    var thisUrl: URL {
        get { return url}
        set {
            url = newValue
        }
    }

    lazy var sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.sessionConfiguration)
    
    init?(url: URL?) {
        guard let theUrl = url else {
            return nil
        }
        self.url = theUrl
    }
    
    typealias JSONDictionaryHandler = (([String:Any]?) -> Void)
    
    func downloadJSON(_ completion: @escaping JSONDictionaryHandler){
        
        //TODO: Handle all below thrown error by showing a no-network connection icon instead of a weather icon
        
        let request = URLRequest(url: self.thisUrl)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
            
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200: //successful
                        if let data = data {
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                
                                guard JSONSerialization.isValidJSONObject(jsonDictionary) else {
                                    showMessage(title: "Error processing JSON data", message: "JSONSerialization.isValidJSONObject(jsonDictionary) = false")
                                    return
                                }
                                
                                completion(jsonDictionary as? [String:Any])
                            } catch let error as NSError{
                                //throw JsonError.unsucessfulProcessing(reason: "\(error?.localizedDescription ?? "nil")")
                                showMessage(title: "Error processing JSON data", message: error.localizedDescription)
                            }
                        }
                    default:
                        //throw HttpError.unsucessfulHttpResponse(code:"\(httpResponse.statusCode)")
                        showMessage(title: "HTTP Response Code", message: "\(httpResponse.statusCode)")
                    }
                }
            } else {
                //throw UrlError.unsucessfulUrl(reason: "\(error?.localizedDescription ?? "nil")")
                showMessage(title: "URL Error", message: "\(error?.localizedDescription ?? "nil")")
            }
        }
        dataTask.resume()
    }
}
