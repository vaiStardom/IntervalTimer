//
//  IntervalTimerNetworkJSON.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-03.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//This class dwonloads any json from the given url
class IntervalTimerDownloadJSON {
    
    //MARK: - Properties
    fileprivate var url: URL
    
    //MARK: - Public get/set properties
    var thisUrl: URL {
        get { return url}
        set {
            url = newValue
        }
    }

    //MARK: - Lazy vars
    lazy var sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.sessionConfiguration)

    //MARK: - Typealias
    typealias JSONDictionaryHandler = (([String:Any]?) -> Void)

    init?(url: URL?) {
        guard let theUrl = url else {
            return nil
        }
        self.url = theUrl
    }
    
    func downloadJSON(_ completion: @escaping JSONDictionaryHandler){
    
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
                            } catch let error {
                                print("------> ERROR IntervalTimerNetworkJSON downloadJSON(), desc.: \(error)")
                                //throw JsonError.unsucessfulProcessing(reason: "\(error?.localizedDescription ?? "nil")")
                                showMessage(title: "JSON Error", message: "IntervalTimerNetworkJSON downloadJSON(), desc.: \(error)")
                            }
                        }
                    default:
                        //throw HttpError.unsucessfulHttpResponse(code:"\(httpResponse.statusCode)")
                        showMessage(title: "HTTP Error", message: "IntervalTimerNetworkJSON downloadJSON(), HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            } else {
                //throw UrlError.unsucessfulUrl(reason: "\(error?.localizedDescription ?? "nil")")
                showMessage(title: "URL Error", message: "IntervalTimerNetworkJSON downloadJSON(), desc.: \(String(describing: error))")
            }
        }
        dataTask.resume()
    }
}
