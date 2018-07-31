//
//  UdacityConvenience.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-07.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    func authenticateWithLogin(email: String, password: String,
                               completionHandlerLogin: @escaping (_ error: NSError?)
        -> Void) {
        
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        
        let task = taskforPostMethod(request: request) { (parsedResult, error)  in
            
            if let error = error {
                completionHandlerLogin(error)
            } else{
                
                guard let accountDictionary = parsedResult?[UdacityAPI.JSONResponseKeys.Account] as? [String:AnyObject] else {
                    return
                }
                
                
                guard let registered = accountDictionary[UdacityAPI.JSONResponseKeys.Registered] as? Bool else {
                    return
                }
                
                
                guard let accountKey = accountDictionary[UdacityAPI.JSONResponseKeys.Key] as? String else {
                    return
                }
                
                
                guard let sessionDictionary = parsedResult?[UdacityAPI.JSONResponseKeys.Session] as? [String:AnyObject] else {
                    return
                }
                
                
                guard let sessionID = sessionDictionary[UdacityAPI.JSONResponseKeys.Session] as? String else {
                    return
                }
                
                
                if registered {
                    self.AccountKey = accountKey
                    self.SessionID = sessionID
                    
                    completionHandlerLogin(nil)
                    
                }
                else {
                    
                    let errorMsg = "No account found with these initials"
                    let userInfo = [NSLocalizedDescriptionKey : errorMsg]
                    completionHandlerLogin(NSError(domain: errorMsg, code: 2, userInfo: userInfo))
            }
        }
    }
}
    
    
    
    func deleteSessionID(_ completionHandlerFordelete: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?)->Void){
        
        let parameters = [String:AnyObject]()
        
        let methodFordeletion = taskforDeleteSession(UdacityAPI.Methods.session, parameters: parameters as [String:AnyObject]) { (results, error) in
            if let error = error {
                completionHandlerFordelete(false, nil, error.localizedDescription)
            } else if let session = results?[UdacityAPI.JSONResponseKeys.Session] as? [String:AnyObject]{
                let sessionID = session[UdacityAPI.UdacityJSONParameters.sessionID] as? String
                completionHandlerFordelete(true, sessionID, nil)
            } else {
                print("Couldn't find sessionID in results")
                completionHandlerFordelete(false, nil, "Session deletion failed")
                
            }
        }
    }
    
    func sessionLogout(_ completionHandlerForLogout: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        self.deleteSessionID() { (success, sessionID, errorString) in
            
            if success {
                ParseClient.sharedInstance().sessionID = nil
                completionHandlerForLogout(success, errorString)
            }   else {
                completionHandlerForLogout(false, errorString)
            }
        }
    }
    
    func getuserInfo(_ completionHandlerforGet: @escaping (_ success: [StudentInformation]?, _ errorString:NSError?)->Void){
        let parameters = [String:AnyObject]()
        
        var mutableMethod:String = UdacityAPI.Methods.userID
        mutableMethod = subtitutekeyformethod(mutableMethod, UdacityAPI.JSONResponseKeys.Key, ParseAPI.JSONResponseKeys.objectID)!
        
        let methodforgettinginfo = taskforGetmethod(mutableMethod, parameters as [String:AnyObject]) { (results, error) in
            if let error = error {
                completionHandlerforGet(nil, error)
            } else {
                if let results = results?[UdacityAPI.JSONResponseKeys.UserInfo] as? [String:AnyObject] {
                    let student = StudentInformation.resultsarray([results])
                    completionHandlerforGet(student, nil)
                } else {
                    completionHandlerforGet(nil, NSError(domain: "getUserInfo parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "could not parse getUserInfo"]))
            }
        }
    }
}

}
