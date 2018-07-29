//
//  ParseStudent.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-10.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

struct ParseStudent {
    
    let userID: String?
    let objectID: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    
    init(dictionary: [String:Any]){
        
        userID = dictionary[ParseAPI.JSONResponseKeys.userID] as? String
        objectID = dictionary[ParseAPI.JSONResponseKeys.objectID] as? String
        firstName = dictionary[ParseAPI.JSONResponseKeys.firstName] as? String
        lastName = dictionary[ParseAPI.JSONResponseKeys.lastName] as? String
        mapString = dictionary[ParseAPI.JSONResponseKeys.mapString] as? String
        mediaURL = dictionary[ParseAPI.JSONResponseKeys.mediaURL] as? String
        longitude = dictionary[ParseAPI.JSONResponseKeys.longitude] as? Double
        latitude = dictionary[ParseAPI.JSONResponseKeys.latitude] as? Double
    }
    
    var labelName: String {
        var name = ""
        if !(firstName?.isEmpty)! {
            name = firstName!
        }
        if !(lastName?.isEmpty)! {
            if name.isEmpty {
                name = lastName!
            } else {
                name += " \(lastName)"
            }
        }
        if name.isEmpty {
            name = "No name provided"
        }
        return name
    }
    
    static func studentsJSON(_ results: [[String:AnyObject]]) -> [ParseStudent]{
        var students = [ParseStudent]()
        for result in results {
            students.append(ParseStudent(dictionary: result))
            if (result["latitude"] as? Double) != nil, (result["longitude"] as? Double) != nil {
                students.append(ParseStudent(dictionary: result))
            }
        }
        return students
    }
    
    
    static func studentFromResults(_ results: [String:AnyObject]) -> ParseStudent {
        return ParseStudent(dictionary: results)
    }
    
    
    final class StudentStorage {
        
        static var sharedInstance = [ParseStudent]()
        
        private init() {}
        
        static var studentsInformation = [ParseStudent]()
    }
    
}
