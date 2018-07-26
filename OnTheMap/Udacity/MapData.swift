//
//  MapData.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-01.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation


class Mapdata {
    
    let ParseID : String = Constants.ParseID
    let ParseAPI : String = Constants.ParseAPI
    
    let parseURL = URL(string: "https://parse.udacity.com/parse/classes")
    
    var refresh = false
    
    func get100infoofstudents(_ completionhander: @escaping (_ success: Bool, _ errorString: String) -> Void) {
        
        var request = URLRequest(url: URL(string: "\(self.parseURL)/StudentLocation?limit=100&order=-updatedAt")!)
        
        request.httpMethod = "GET"
        request.addValue(self.ParseID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(self.ParseAPI, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completionhander(false, error!.localizedDescription)
                return
            }
                let JSONerror : Error? = nil
                let parsedResult = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)) as? [String:AnyObject]
                if let error = JSONerror {
                    completionhander(false, error.localizedDescription)
                } else {
                    if let results = parsedResult!["results"] as? [String : AnyObject]{
                    StudentData.sharedInstance().mappoints.removeAll(keepingCapacity: true)
                        for result in results {
                            StudentData.sharedInstance().mappoints.append(StudentInformation(dictionary: results))
                        }
                    self.refresh = true
                    completionhander(true, "Updated map points")
                    } else{
                        completionhander(false, "Failed to update map points. Check your internet connection")
                    
            }
            }
        }
        task.resume()
    }
    
    func getonestudentslocation(_ completionhandler: @escaping(_ success: Bool, _ errorString: String)->Void ){
        let urlString = "\(parseURL)/StudentLocation?where=%7B%22uniqueKey%22%3A%221234%22%7D"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionhandler(false, error!.localizedDescription)
            }
            
            let JSONerror : Error? = nil
            let parsedResult = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)) as? [String:AnyObject]
            
            if let error = JSONerror {
                completionhandler(false, error.localizedDescription)
            }
            
            if let results = parsedResult!["results"] as? [String:AnyObject]{
                for result in results{
                    StudentData.sharedInstance().mappoints.append(StudentInformation(dictionary: results))
                }
                completionhandler(true, "Received an individual pin")
            } else{
                completionhandler(false,"Didn't receive the pin")
            }
           
        }
        task.resume()
    }
    
    func postalocation(_ latitude: String, _ longitude : String, _ address: String, _ link: String,
        _ completionHandler: @escaping(_ success: Bool, _ errorString: String)-> Void){
        
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"uniqueKey\": \"\(UdacityAPI.sharedInstance().userKey)\", \"firstName\": \"\(UdacityAPI.sharedInstance().firstname)\", \"lastName\": \"\(UdacityAPI.sharedInstance().lastname)\",\"mapString\": \"\(address)\", \"mediaURL\": \"\(link)\",\"latitude\": \"\(latitude)\", \"longitude\": \"\(longitude)\"}".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                completionHandler(false, "Failed to put a pin on the map")
            }
            
            else{
                completionHandler(true, "Pin update successful")
            }
        }
        task.resume()
    }
    
    func updatepin(_ latitude:String, _ longitude: String, _ address:String,_ objectID: String ,_ link:String, _ completionHandler: @escaping(_ success: Bool, _ errorString: String)-> Void) {
        
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation/\(objectID)")!)
        
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"uniqueKey\": \"\(UdacityAPI.sharedInstance().userKey)\", \"firstName\": \"\(UdacityAPI.sharedInstance().firstname)\", \"lastName\": \"\(UdacityAPI.sharedInstance().lastname)\",\"mapString\": \"\(address)\", \"mediaURL\": \"\(link)\",\"latitude\": \"\(latitude)\", \"longitude\": \"\(longitude)\"}".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, "Failed to update the location of the pin")
            } else{
                completionHandler(true, "Updated the new information of the pin")
            }
        }
        task.resume()
    
    }
    
    func logout(){
        
    }
    
    
    
    
    
    
    
    
    
    class func sharedInstance() -> Mapdata{
        struct singleton {
            static let sharedInstance = Mapdata()
        }
        return singleton.sharedInstance
    }

}
