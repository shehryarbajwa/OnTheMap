//
//  ParseClient.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-09.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

class ParseClient {
    
    var requestToken: String? = nil
    var sessionID: String? = nil
    var userID: String? = nil
    
    init() {
    }
    
    private func URLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = ParseAPI.URLParameters.APIScheme
        components.host = ParseAPI.URLParameters.APIHost
        components.path = ParseAPI.URLParameters.APIPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        // TESTING URL
        print("url: \(String(describing: components.url))")
        
        return components.url!
    }
    
    func taskforGetMethod(_ method:String, _ parameters : [String:AnyObject], completionHandlerForGet: @escaping(_ result: AnyObject?,_ error: NSError? )->Void) ->URLSessionDataTask {
        
        var parameterswithApiKey = parameters
        parameterswithApiKey[ParseAPI.ParseApplicationKeys.parseAPIKey] = ParseAPI.Applicationdata.APIKey as AnyObject
        
        var request = URLRequest(url: URLFromParameters(parameterswithApiKey, withPathExtension: method))
        request.addValue(ParseAPI.Applicationdata.APIKey, forHTTPHeaderField: ParseAPI.ParseApplicationKeys.parseAPIKey)
        request.addValue(ParseAPI.Applicationdata.ApplicationID, forHTTPHeaderField: ParseAPI.ParseApplicationKeys.parseApplicationID)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func senderror(_ error:String){
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGet(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else{
                senderror("There was an error with your request")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                senderror("There was an error with your statuscode")
                return
                
            }
            guard let data = data else {
                senderror("There was an error with your data")
                return
            }
            
            self.convertDataforJSON(data, completionHandlerForConvertData: completionHandlerForGet)
            
        }
        task.resume()
        
        return task
        
    }
    
    
    func taskforPostMethod(_ method:String, _ parameters: [String:AnyObject], _ jsonBody:String, completionhandlerforPost: @escaping (_ result: AnyObject?, _ error: NSError?)->Void) -> URLSessionDataTask {
        
        var parameterswithApikey = parameters
        parameterswithApikey[ParseAPI.ParseApplicationKeys.parseAPIKey] = ParseAPI.Applicationdata.APIKey as AnyObject
        
        var request = URLRequest(url: URLFromParameters(parameterswithApikey, withPathExtension: method))
        request.addValue(ParseAPI.Applicationdata.APIKey, forHTTPHeaderField: ParseAPI.ParseApplicationKeys.parseAPIKey)
        request.addValue(ParseAPI.Applicationdata.ApplicationID, forHTTPHeaderField: ParseAPI.ParseApplicationKeys.parseApplicationID)
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: (request as? URLRequest)!) { (data, response, error) in
            
            func senderror(_ error:String){
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionhandlerforPost(nil, NSError(domain: "taskforPostMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error==nil) else{
                senderror("There was an error in your request")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else{
                senderror("Your request returned a status code other than 2XX")
                return
            }
            
            guard let data = data else {
                senderror("There was an error with your data request")
                return
            }
            
            self.convertDataforJSON(data, completionHandlerForConvertData: completionhandlerforPost)
            
        }
        task.resume()
        return task
        
    }
    
    func taskforPUTMethod(_ method:String, _ parameters:[String:AnyObject], jsonBody:String, completionHandlerforPut:@escaping (_ results:AnyObject? , _ error:NSError?)->Void) ->URLSessionDataTask {
        
        var parameterswithApikey = parameters
        parameterswithApikey[ParseAPI.ParseApplicationKeys.parseAPIKey] = ParseAPI.Applicationdata.APIKey as AnyObject
        
        var request = URLRequest(url: URLFromParameters(parameterswithApikey, withPathExtension: method))
        request.addValue(ParseAPI.Applicationdata.APIKey, forHTTPHeaderField: ParseAPI.ParseApplicationKeys.parseAPIKey)
        request.addValue(ParseAPI.Applicationdata.ApplicationID, forHTTPHeaderField: ParseAPI.ParseApplicationKeys.parseApplicationID)
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: (request as? URLRequest)!) { (data, response, error) in
            func senderror(_ error:String){
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerforPut(nil, NSError(domain: "taskForPutMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error==nil) else{
                senderror("There was an error with your request")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
                senderror("Your request returned a statuscode other than 2xx")
                return
            }
            guard let data = data else {
                senderror("There was an error with your data parsing")
                return
            }
            self.convertDataforJSON(data, completionHandlerForConvertData: completionHandlerforPut)
        }
        task.resume()
        return task
        
        
    }
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static let sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
    func subtitutekeyinMethod( method:String, key: String? , value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    func convertJSONDictionarytoString(_ dictionary:[String:AnyObject]) -> String? {
        
        if JSONSerialization.isValidJSONObject(dictionary){
            do{
                let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
                return String(data:data!, encoding:.utf8)!
            } catch {
                print("Couldn't convert data dictionary")
            }
            return nil
        }
        return ""
    }
    
    
    
    
    
    
    private func convertDataforJSON(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let errormessage = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: errormessage))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    
    
    
}
