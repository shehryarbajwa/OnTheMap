//
//  api.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-05-29.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation


class API {
    
    var userKey = ""
    var firstname = ""
    var lastname = ""
    
    
    func loginwithudacity(username:String, password:String, completionHandler: @escaping (_ success:Bool, _ errorString:String) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\" , \"password\": \"\(password)\")}}".data(using:.utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, error!.localizedDescription)
                return
            }
            //remove the first five characters in the response
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            
            let parsedResult = (try! JSONSerialization.jsonObject(with: newData!, options: JSONSerialization.ReadingOptions.allowFragments)) as? [String:AnyObject]
            
            if let userKey = parsedResult!["account"]?.value(forKey:"key") as? String {
                self.userKey = userKey
                completionHandler(true, "Good")
            } else{
                completionHandler(false,"Incorrect credentials")
            }
            
            
            
        }
        
        task.resume()
        
    }
    
    func loginwithname(firstname:String, lastname: String, completionHandler: @escaping(_ success:Bool, _ errorString:String) ->Void) {
        
        var request = URLRequest(url: (URL(string: "https://www.udacity.com/api/users/\(userKey)")! as? URL)!)
        
       let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                completionHandler(false, error!.localizedDescription)
                return
            }
        let range = Range(5..<data!.count)
        let newData = data?.subdata(in: range)
        
            
            let parsedresult = (try? JSONSerialization.jsonObject(with: newData!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject])
            
            if let name = parsedresult!!["user"]?.value(forKey:"Firstname") as? String{
                self.firstname = firstname
                completionHandler(true, "Login successful")
            }else{
                completionHandler(false, "Incorrect credentials")
            }
        }
        
    }
    
}
