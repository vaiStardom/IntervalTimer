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
        
        let request = URLRequest(url: self.thisUrl)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
            
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200: //successful
                        if let data = data {
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(jsonDictionary as? [String:Any])
                            } catch let error as NSError{
                                //TODO: get rid of this alert and replace with error handling unobtrusive to the UX
                                showMessage(title: "Error processing JSON data", message: error.localizedDescription)
                            }
                        }
                    default:
                        //TODO: get rid of this alert and replace with error handling unobtrusive to the UX
                        showMessage(title: "HTTP Response Code", message: "\(httpResponse.statusCode)")
                    }
                }
            } else {
                //TODO: Handle URLSession error
                print("---------> Error: \(error?.localizedDescription ?? "nil")")
            }
        }
        dataTask.resume()
    }
}
