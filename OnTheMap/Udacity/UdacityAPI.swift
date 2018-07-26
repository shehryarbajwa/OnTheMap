//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-05-28.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

class UdacityAPI {
    
    var firstname = ""
    var lastname = ""
    var userKey = ""
    
    func loginToUdacity(username : String, password: String, completionHander: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\" : \"\(username)\" , \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                completionHander(false, "an error occured")
                return
            }
            
            
            guard let data = data else {
                print("The request returned no data.")
                return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            
            var parsedResult = (try? JSONSerialization.jsonObject(with: newData, options: JSONSerialization.ReadingOptions.allowFragments)) as! [String:AnyObject]
            
            
            
            
            if let userKey = (parsedResult["account"]?.value(forKey: "key") as? String ){
                self.userKey = userKey
                completionHander(true, nil)
            } else{
                completionHander(false, "Incorrect username or password")
            }
            
        }
        task.resume()
        
    }
    
    func setfirstnamelastname(completionHandler: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let request = URLRequest(url: URL(string: "https://www.udacity.com/api/users/\(self.userKey)")!)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, error!.localizedDescription)
                return
            }
        let range = Range(5..<data!.count)
        let newData = data?.subdata(in: range)
            
        let parsedResult = (try? JSONSerialization.jsonObject(with: newData!, options: JSONSerialization.ReadingOptions.allowFragments)) as! [String:AnyObject]
        
        if let firstname = parsedResult["user"]?.value(forKey: "first_name") as? String {
            self.firstname = firstname
            completionHandler(true, nil)
        } else{
                completionHandler(false, "Incorrect first name entered")
            }
            if let lastname = parsedResult["user"]?.value(forKey: "last_name") as? String {
                self.lastname = lastname
                completionHandler(true, nil)
            } else{
                completionHandler(false,"Incorrect last name. Doesn't match the Udacity records")
            }
            
        }
        task.resume()
    }
    
    class func sharedInstance() -> UdacityAPI{
        struct singleton {
            static let sharedInstance = UdacityAPI()
        }
        return singleton.sharedInstance
    }
    
}

