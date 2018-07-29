//
//  StudentData.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-01.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    let userID: String
    let FirstName: String
    let LastName: String
    
    init (resultsdictionary: [String:AnyObject] ) {
        userID = resultsdictionary[UdacityAPI.JSONResponseKeys.Key] as! String
        FirstName = resultsdictionary[UdacityAPI.JSONResponseKeys.FirstName] as! String
        LastName = resultsdictionary[UdacityAPI.JSONResponseKeys.LastName] as! String
    }
    
    static func resultsarray(_ results: [[String:AnyObject]])-> [StudentInformation] {
        var students = [StudentInformation]()
        for result in results {
            students.append(StudentInformation(resultsdictionary: result))
        }
        return students
    }
}

