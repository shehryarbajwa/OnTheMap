//
//  ParseConvenience.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-11.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

extension ParseClient{
    
    
    func getmultiplelocations(_ completionhandlerforlocations: @escaping(_ results:[ParseStudent]? , _ error:NSError?)->Void) {
    
        var parameters = [String:AnyObject]()
        
        parameters[ParseAPI.QueryKeys.Limit] = "100" as AnyObject?
        parameters[ParseAPI.QueryKeys.Order] = "-updatedAt" as AnyObject?
        parameters[ParseAPI.QueryKeys.Skip] = "400" as AnyObject?
        
        let _ = taskforGetMethod(ParseAPI.Methods.StudentLocation, parameters) { (results, error) in
            if let error = error {
                completionhandlerforlocations(nil, error)
            } else {
                if let results = results?[ParseAPI.JSONResponseKeys.StudentLocation] as? [[String:AnyObject]] {
                    let student = ParseStudent.studentsJSON(results)
                    completionhandlerforlocations(student, nil)
                } else {
                    completionhandlerforlocations(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
                }
            }
        }
    
        func getsingleLocation(_ userID:String,  _ completionhandlerforsinglelocation: @escaping(_ results: ParseStudent?,   _ error: NSError?)->Void) {
            
            var parameterswithkeys = [String:AnyObject]()
            
            parameterswithkeys[ParseAPI.QueryKeys.Where] = "{\"uniqueKey\":\"\(userID)\"}" as AnyObject?
            
            let _ = taskforGetMethod(ParseAPI.Methods.StudentLocation, parameterswithkeys) { (result, error) in
                if let error = error {
                    completionhandlerforsinglelocation(nil, error)
                } else {
                    if let results = result?[ParseAPI.JSONResponseKeys.StudentLocation] as? [[String:AnyObject]]{
                        if (results.first != nil) {
                            let student = ParseStudent.studentsJSON(results)
                        } else {
                            completionhandlerforsinglelocation(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
                        }
                    }
                }
            }
            
        }
        func posttoStudentLocations(_ student: [String:AnyObject], _ completionhandlerforPost: @escaping (_ success: Bool, _ error:NSError?)->Void){
            
            var parameters = [String:AnyObject]()
            
            let jsonBody = convertJSONDictionarytoString(student)
            
            let _ = taskforPUTMethod(ParseAPI.Methods.StudentLocation, parameters, jsonBody: jsonBody!) { (results, error) in
                if let error = error {
                    completionhandlerforlocations(nil, error)
                } else {
                    if let results = results?[ParseAPI.JSONResponseKeys.objectID] as? String {
                        completionhandlerforPost(true, nil)
                    } else {
                        completionhandlerforPost(false, NSError(domain: "postStudentLocation parsing", code: 1, userInfo: [NSLocalizedDescriptionKey: "Couldnot parse StudentLocation"]))
                    }
                }
            }
            
        
            func updatestudentLocation(_ objectID:String, _ student:[String:AnyObject], _ completionhandlerforupdate:@escaping(_ success: Bool, _ error:NSError?)->Void){
                
                var parameters = [String:AnyObject]()
                
                let jsonBody = convertJSONDictionarytoString(student)
                
                var mutableMethod = ParseAPI.Methods.Objectidentity
                mutableMethod = subtitutekeyinMethod(method: mutableMethod, key: ParseAPI.JSONResponseKeys.objectID, value: objectID)!
                
                let _ = taskforPUTMethod(mutableMethod, parameters, jsonBody: jsonBody!) { (results, error) in
                    if let error = error {
                        completionhandlerforupdate(false, error)
                    } else {
                        if let results = results?[ParseAPI.JSONResponseKeys.updatedAt] as? Date{
                            completionhandlerforupdate(true, nil)
                        } else {
                            completionhandlerforupdate(false, NSError(domain: "updateStudentLocation", code: 1, userInfo: [NSLocalizedDescriptionKey: "Couldn't parse StudentLocation"]))
                        }
                    }
                }
                
                
                
            }
            
            
            
            
            
            
        }
    
    
    
    
}
}
