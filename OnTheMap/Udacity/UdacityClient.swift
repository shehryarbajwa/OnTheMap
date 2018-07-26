//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-07-05.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation


class UdacityClient {
    
    func URLFromParameters (_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL{
        
        var components = URLComponents()
        
        components.scheme = UdacityAPI.Constants.APIScheme
        components.host = UdacityAPI.Constants.ApiHost
        components.path = UdacityAPI.Constants.ApiPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryitems = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryitems)
        }
        return components.url!
    }
    
    
    func taskforGetmethod(_ method: String, _ parameters: [String:AnyObject], completionHandlerforGet: @escaping(_ result: AnyObject?, _ error: NSError?)->Void) -> URLSessionDataTask {
        
        var request = URLRequest(url: URLFromParameters(parameters, withPathExtension: method))
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response,error) in
            
            guard (error == nil) else {
                print("Error: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            let range = Range(5..<data.count)
            
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerforGet)
        }
        task.resume()
        
        return task
        
    }
    
    func taskForPostMethod(_ method: String, _ parameters: [String:AnyObject], jsonBody: String, completionHandlerforPost: @escaping(_ result: AnyObject?, _ error: NSError?)->Void) -> URLSessionDataTask {
        
        var parameterswithApikey = parameters
        
        var request = URLRequest(url: URLFromParameters(parameterswithApikey, withPathExtension: method))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            func senderror(_ error: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerforPost(nil, NSError(domain: "taskForPOSTTMethod", code: 1, userInfo: userInfo))
            }
            
            guard(error == nil) else{
                senderror("The internet connection seems to be offline")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            let range = Range(5..<data.count)
            
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerforPost)
            
        }
        task.resume()
        return task
        
        
    }
    
    func taskforDeleteSession(_ method: String, parameters: [String:AnyObject] , completionHandlerforDelete :@escaping (_ result: AnyObject? , _ error: NSError?) -> Void) -> URLSessionDataTask {
        
    var parameterswithApiKey = parameters
    
    var request = URLRequest(url: URLFromParameters(parameterswithApiKey, withPathExtension: method))
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: (request as? URLRequest)!) { (data, response, error) in
            guard (error == nil) else {
                print("Your deletion request couldn't be fulfilled")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status other than 2xx")
                return
            }
            
            guard let data = data else{
                print("Your request returned no data")
                return
            }
            let range = Range(5..<data.count)
            let newdata = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newdata, completionHandlerForConvertData: completionHandlerforDelete)
        }
        task.resume()
        return task
    
    }
    
     private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let errormessage = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: errormessage))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    
    func subtitutekeyformethod (_ method: String, _ key: String , _ value: String) -> String? {
        
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
        
    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static let sharedInstance = UdacityClient()
            private init () {}
        }
        return Singleton.sharedInstance
    }
        
    
}
