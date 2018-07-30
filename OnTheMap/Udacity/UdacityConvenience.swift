//
//  UdacityConvenience.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-07.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    func authenticateWithLogin(username: String, password: String, _ completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?)-> Void) {
        self.postSessionID(username, password) { (success, registered, sessionID, uniqueKey, errorString)  in
            
            if success {
                ParseClient.sharedInstance().sessionID = sessionID
                ParseClient.sharedInstance().userID = uniqueKey
                completionHandlerForAuth(success, nil)
            } else {
                completionHandlerForAuth(false, errorString)
            }
        }
    }
    
    
    
    
    func postSessionID( _ username: String, _ password:String, _ completionHandlerforsession: @escaping ( _ success: Bool, _ registered: Bool, _ uniqueKey:String?, _ ID:String?, _ errorString:String?)-> Void ){
        
        let parameters = [String:AnyObject]()
        
        let jSONbody = "{\"udacity\": {\"\(UdacityAPI.UdacityJSONParameters.username)\": \"\(username)\", \"\(UdacityAPI.UdacityJSONParameters.password)\": \"\(password)\"}}"
        
        let methodtoexecute = taskForPostMethod(UdacityAPI.Methods.session, parameters as [String:AnyObject], jsonBody: jSONbody) { (results, error) in
            if let error = error {
                completionHandlerforsession(false, false, nil, nil, error.localizedDescription)
            }
            if let session = results?[UdacityAPI.JSONResponseKeys.Session] as? [String:AnyObject], let account = results?[UdacityAPI.JSONResponseKeys.Account] as? [String:AnyObject]{
                let sessionID = session[UdacityAPI.UdacityJSONParameters.sessionID] as? String
                let uniqueKey = account[UdacityAPI.JSONResponseKeys.Key] as? String
                let registered = account[UdacityAPI.JSONResponseKeys.Registered] as? Bool
                
                completionHandlerforsession(true, true, uniqueKey, sessionID, nil)
            } else {
                print("Couldn't find session ID. Login failed")
                completionHandlerforsession(false, false, nil, nil, "Login failed")
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
